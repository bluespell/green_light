class Token
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable

  columns :value => :string

  validate :value, :presence => true

  def self.value
    last ? last.value : nil
  end
end
