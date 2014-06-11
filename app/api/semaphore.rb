class Semaphore
  API_URL = 'https://semaphoreapp.com/api/v1/'
  PROJECTS_URL = API_URL + 'projects.json'

  def self.projects(token, &block)
    return mock_data(&block) if token == "secret"

    AFMotion::JSON.get PROJECTS_URL, :auth_token => token do |response|
      block.call response
    end
  end

  def self.mock_data(&block)
    path = NSBundle.mainBundle.pathForResource("data", ofType:"json")
    data = NSData.dataWithContentsOfFile(path)

    block.call FakeData.new(data)
  end
end
