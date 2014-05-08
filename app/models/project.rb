class Project
  attr_accessor :name, :id, :hash_id, :favorite, :branches

  def initialize(name, id, hash_id)
    @name     = name
    @id       = id
    @hash_id  = hash_id
    @favorite = false
    @branches = []
  end

  def self.initialize_from_json(json)
    [].tap do |projects|
      json.each do |hash|
        project = Project.new hash["name"], hash["id"], hash["hash_id"]
        project.build_branches hash["branches"]

        projects << project
      end
    end
  end

  def build_branches(branches_hash)
    branches_hash.each do |hash|
      @branches << Branch.new({
        :name         => hash["branch_name"],
        :result       => hash["result"],
        :project_name => hash["project_name"]
      })
    end
  end

  def color(branch="master")
    status = select_branch(branch).result.to_sym

    color_status[status]
  end

  def select_branch(name)
    @branches.select { |branch| branch.name == name }.first
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
