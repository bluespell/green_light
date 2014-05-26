class BranchCell < UITableViewCell
  extend IB
  include ColorHelper, LayoutHelper

  attr_accessor :branch

  outlet :branch_name, UILabel
  outlet :last_build, UILabel
  outlet :branch_status, UILabel
  outlet :branch_status_background, UIView
  outlet :last_line_detail, UIView

  def configure(branch, index)
    @branch = branch

    branch_name.text = branch.name
    branch_status.text = branch.result
    branch_status_background.setBackgroundColor color[:strong]
    inset_shadow branch_status_background

    last_build.text = branch.human_building_date
    last_line_detail.hidden = last_branch?(index)

    setBackgroundColor color[:light]

    self
  end

  private

  def last_branch?(index)
    count == index + 1
  end

  def color
    send "#{@branch.result}_colors"
  end

  def count
    @count ||= @branch.brothers.count
  end
end
