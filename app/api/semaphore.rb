class Semaphore
  API_URL = 'https://semaphoreapp.com/api/v1/'
  PROJECTS_URL = API_URL + 'projects.json'

  # TODO: this actually ins't a login call. We should call it 'projects' or something
  def self.login(token, &block)
    AFMotion::JSON.get PROJECTS_URL, :auth_token => token do |response|
      block.call response
    end
  end
end
