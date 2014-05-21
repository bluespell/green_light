class Branch
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include TimeHelper

  columns :name                => :string,
          :result              => :string,
          :started_at          => :date,
          :finished_at         => :date,
          :human_building_date => :string

  belongs_to :project

  def started_at=(time)
    time = time_from_string(time) if time.is_a? String

    @data[:started_at] = time
  end

  def finished_at=(time)
    time = time_from_string(time) if time.is_a? String

    @data[:finished_at] = time
  end

  def failed?
    result == 'failed'
  end

  def pending?
    result == 'pending'
  end

  def brothers
    project.branches
  end

  def finished_at_or_now
    finished_at || Time.new
  end
end
