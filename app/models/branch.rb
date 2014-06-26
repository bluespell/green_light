class Branch < CDQManagedObject
  def self.destroy_all!
    all.each { |b| b.destroy }

    cdq.save
  end

  def human_building_date
    return 'building...' unless finished_at

    finished_at.prettyTimestampSinceNow
  end

  def brothers
    project.branches
  end
end
