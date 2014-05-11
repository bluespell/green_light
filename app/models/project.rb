class Project
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :semaphaore_id => :integer,
          :name          => :string,
          :hash_id       => :string,
          :favorite      => { :type => :boolean, :default => false }

  has_many :branches, :dependent => :destroy

  def self.any_favorite?
    all.any?(&:favorite)
  end

  def master_branch
    select_branch "master"
  end

  def status_color
    status = master_branch.result.to_sym

    color_status[status]
  end

  def last_build
    master_branch.finished_at
  end

  private

  def color_status
    {
      :passed => "E6F4CA".to_color,
      :failed => "F4D9CA".to_color,
      :pending => "DDEFF8".to_color
    }
  end

  def select_branch(name)
    branches.where(:name).eq(name).first
  end
end
