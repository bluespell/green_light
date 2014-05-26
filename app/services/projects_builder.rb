class ProjectsBuilder
  extend TimeHelper

  def self.build!(projects)
    Project.destroy_all

    projects.each do |raw_project|
      project = Project.create({
        :semaphore_id => raw_project["id"],
        :name => raw_project["name"],
        :hash_id => raw_project["hash_id"]
      })

      raw_project["branches"].each do |branch|
        branch = project.branches.create({
          :name          => branch["branch_name"],
          :result        => branch["result"],
          :project_name  => branch["project_name"],
          :started_at    => branch["started_at"],
          :finished_at   => branch["finished_at"],
          :building_date => time_from_string(branch["finished_at"])
        })

        branch.save
      end

      project.save

      App.shared.delegate.write_model_data
    end
  end
end
