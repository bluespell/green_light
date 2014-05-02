class Semaphore
  API_URL = 'https://semaphoreapp.com/api/v1/'
  PROJECTS_URL = API_URL + 'projects.json'

  def self.login(token, &block)
    BW::HTTP.get(PROJECTS_URL + "?auth_token=#{token}") do |response|
      block.call response
    end
  end
end