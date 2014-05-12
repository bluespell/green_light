class Project
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :semaphore_id  => :integer,
          :name          => :string,
          :hash_id       => :string,
          :favorite      => { :type => :boolean, :default => false }

  has_many :branches, :dependent => :destroy

  def self.favorites
    where(:favorite).eq(true)
  end

  def self.any_favorite?
    favorites.count > 0
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
      :passed  => { :foreground => "E6F4CA".to_color, :background => "EAF3D8".to_color },
      :failed  => { :foreground => "F4D9CA".to_color, :background => "F3E2D8".to_color },
      :pending => { :foreground => "DDEFF8".to_color, :background => "EAF3F7".to_color }
    }
  end

  def select_branch(name)
    branches.where(:name).eq(name).first
  end
end
