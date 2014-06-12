class FakeData
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def object
    BW::JSON.parse @data
  end

  def success?
    true
  end
end
