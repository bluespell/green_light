class RefreshProjectsCommand
  def self.run(token, &block)
    favorites = Project.favorites.map(&:semaphore_id)

      RemoteManager.object_manager.getObjectsAtPath(
        'projects.json',
        parameters: { auth_token: token },
        success: ->(operation, mapping_result) {
          Project.all.each do |project|

            # FIXME
            # http://restkit.org/api/latest/Classes/RKManagedObjectRequestOperation.html
            # Fetch Request Blocks and Deleting Orphaned Objects
            # To avoid this kind of checking, we can use the described methods above to
            # do this automatically
            project.destroy && next unless mapping_result.array.include?(project)

            project.favorite = true if favorites.include?(project.semaphore_id)

            # FIXME: this needs to go to a model `before_save` callback
            project.last_build_cache = project.last_build
          end

          block.call
        },
        failure: ->(operation, error) {
          App.alert('Could not refresh projects')
        }
      )
    end
end
