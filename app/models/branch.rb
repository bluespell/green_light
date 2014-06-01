class Branch < CDQManagedObject
  include TimeHelper

  def human_building_date
    return 'Building...' unless finished_at

    finished_at.prettyTimestampSinceNow
  end

  def brothers
    project.branches
  end
end
