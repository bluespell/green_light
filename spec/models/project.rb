describe 'Project' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Project entity' do
    Project.entity_description.name.should == 'Project'
  end
end
