class Branch
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include TimeHelper

  columns :name        => :string,
          :result      => :string,
          :started_at  => :date,
          :finished_at => :date

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
end
