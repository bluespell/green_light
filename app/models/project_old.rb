class ProjectOld
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter

  columns :semaphore_id  => :integer,
          :name          => :string,
          :hash_id       => :string,
          :favorite      => { :type => :boolean, :default => false },
          :last_build_cache => :time

  has_many :branches, :dependent => :destroy

  def self.favorites
    where(:favorite).eq(true).
    order { |one, two| two.last_build_cache <=> one.last_build_cache }.all
  end

  def self.any_favorite?
    favorites.count > 0
  end

  def self.ordered_by_last_build
    order { |one, two| two.last_build_cache <=> one.last_build_cache }.all
  end

  def before_save(sender)
    @data[:last_build_cache] = master_branch ? last_build_or_now : Time.new

    true
  end

  def ordered_branches
    branches.order { |one, two| two.finished_at_or_now <=> one.finished_at_or_now }.all
  end

  def master_branch
    select_branch "master"
  end

  def status
    master_branch.result
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

  def toggle_favorite
    @data[:favorite] = !@data[:favorite]
  end

  private

  def select_branch(name)
    branches.where(:name).eq(name).first
  end
end
