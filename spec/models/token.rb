describe 'Token' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Token entity' do
    Token.entity_description.name.should == 'Token'
  end
end
