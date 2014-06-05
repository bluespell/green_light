class Branch < CDQManagedObject
  include TimeHelper

  def self.destroy_all!
    all.each { |b| b.destroy }

    cdq.save
  end

  def human_building_date
    return 'Building...' unless finished_at

    finished_at.prettyTimestampSinceNow
  end

  def brothers
    project.branches
  end
end
