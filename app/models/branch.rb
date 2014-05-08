class Branch
  include TimeHelper

  attr_accessor :name, :project_name, :result, :started_at, :finished_at

  def initialize(attrs={})
    attrs.each do |key, value|
      self.send "#{key}=", value
    end
  end

  def started_at=(time)
    @started_at = time_from_string time
  end

  def finished_at=(time)
    @finished_at = time_from_string time
  end
end
