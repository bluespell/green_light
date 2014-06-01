describe 'Branch' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Branch entity' do
    Branch.entity_description.name.should == 'Branch'
  end
end
