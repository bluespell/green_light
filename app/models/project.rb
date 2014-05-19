class Project
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :semaphore_id  => :integer,
          :name          => :string,
          :hash_id       => :string,
          :favorite      => { :type => :boolean, :default => false }

  has_many :branches, :dependent => :destroy

  def self.favorites
    where(:favorite).eq(true).
    order { |one, two| two.last_build_or_now <=> one.last_build_or_now }.all
  end

  def self.any_favorite?
    favorites.count > 0
  end

  def self.ordered_by_last_build
    order { |one, two| two.last_build_or_now <=> one.last_build_or_now }.all
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

  def passed_branches
    branches.where(:result).eq('passed')
  end

  def failed_branches
    branches.where(:result).eq('failed')
  end

  def last_build_or_now
    last_build || Time.new
  end

  private

  # TODO: refactor colors so projects, branches, etc, can reuse
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
