class Project < CDQManagedObject

  scope :favorites, where(:favorite).eq(1).sort_by(:last_build_cache, order: :descending)

  def status
    master_branch.result
  end

  def last_build
    master_branch ? master_branch.finished_at : Time.new
  end

  def master_branch
    branches.where(:name).eq('master').first
  end

  def passed_branches
    branches.where(:result).eq('passed')
  end

  def failed_branches
    branches.where(:result).eq('failed')
  end

  def ordered_branches
    branches.sort_by(:finished_at, order: :descending)
  end

  #FIXME: toggle_favorite is not working
  def toggle_favorite
    favorite = 1
  end

  def self.any_favorite?
    favorites.count > 0
  end

  def self.destroy_all
    # FIXME: Could not find a call to destroy all instances of an entity at once
    all.array.each do |project|
      project.destroy
    end

    cdq.save
  end
end