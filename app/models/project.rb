class Project
  attr_accessor :name, :id, :hash_id, :favorite

  def initialize(name, id, hash_id)
    @name     = name
    @id       = id
    @hash_id  = hash_id
    @favorite = false
  end

  def self.initialize_from_json(json)
    json.map { |project| Project.new(project["name"], project["id"], project["hash_id"]) }
  end

  private

  def color_status
    {
      :passed => "E6F4CA".to_color,
      :failed => "F4D9CA".to_color,
      :pending => "DDEFF8".to_color
    }
  end
end
