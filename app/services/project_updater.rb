class ProjectUpdater
  attr_accessor :json, :favorites, :cdq

  def initialize(json, cdq)
    @json = json
    @cdq = cdq
    @favorites = Project.favorites.map(&:semaphore_id)
  end

  def self.update!(cdq, callbacks)
    Semaphore.projects(Token.value) do |response|

      if response.success?
        self.new(response.object, cdq).update!
        callbacks[:success].call
      elsif response.failure?
        callbacks[:failure].call
      end

      callbacks[:done].call
    end
  end

  def update!
    ProjectsBuilder.build!(json, cdq)

    Project.where(:semaphore_id).in(favorites).each do |project|
      project.favorite = true
    end

    cdq.save
  end
end
