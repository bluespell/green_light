class Project < CDQManagedObject

  scope :favorites, where(:favorite).eq(true).sort_by(:last_build_cache, order: :descending)

  def self.any_favorite?
    where(:favorite).eq(true).count > 0
  end

  def self.destroy_all!
    all.each { |project| project.destroy }

    cdq.save
  end

  def status
    master_branch.result
  end

  def last_build
    (master_branch && master_branch.finished_at) || Time.new
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
    (not_finished_branches.to_a + finished_branches.to_a).flatten
  end

  def not_finished_branches
    branches.where(:finished_at).eq(nil)
  end

  def finished_branches
    branches.where(:finished_at).ne(nil).sort_by(:finished_at, order: :descending)
  end

  def toggle_favorite
    setValue !favorite_to_bool, forKey: :favorite

    cdq.save
  end

  def favorite_to_bool
    favorite == 1 ? true : false
  end
end
