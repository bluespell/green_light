class Semaphore
  API_URL = 'https://semaphoreapp.com/api/v1/'
  PROJECTS_URL = API_URL + 'projects.json'
  DEMO_DATA_URL = 'http://bluespell.us/data.json'

  def self.projects(token, &block)
    url = token == "demo" ? DEMO_DATA_URL : PROJECTS_URL

    AFMotion::JSON.get url, :auth_token => token do |response|
      block.call response
    end
  end
end
