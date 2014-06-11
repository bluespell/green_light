class FakeData
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def object
    sleep 3

    BW::JSON.parse @data
  end

  def success?
    true
  end
end
