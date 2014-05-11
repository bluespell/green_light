class Semaphore
  API_URL = 'https://semaphoreapp.com/api/v1/'
  PROJECTS_URL = API_URL + 'projects.json'

  def self.login(token, &block)
    AFMotion::JSON.get PROJECTS_URL, :auth_token => token do |response|
      block.call response
    end
  end
end
