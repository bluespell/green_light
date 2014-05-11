class Token
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable

  columns :value => :string

  validate :value, :presence => true

  def self.value
    last ? last.value : nil
  end

  def self.create_and_serialize(value)
    self.create(:value => value)

    Token.serialize_to_file "tokens.dat"
  end
end
