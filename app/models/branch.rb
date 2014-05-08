class Branch
  attr_accessor :name, :project_name, :result

  def initialize(attrs={})
    attrs.each do |key, value|
      self.send "#{key}=", value
    end
  end
end
