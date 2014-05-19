class BranchCell < UITableViewCell
  extend IB
  include ColorHelper

  attr_accessor :branch

  outlet :branch_name, UILabel
  outlet :last_build, UILabel
  outlet :branch_status, UILabel
  outlet :branch_status_background, UIView
  outlet :last_line_detail, UIView

  def configure(branch, index)
    @branch = branch

    branch_name.text = branch.name
    last_build.text = branch.finished_at.time_ago_in_words
    branch_status.text = branch.result

    branch_status_background.setBackgroundColor color[:strong]
    setBackgroundColor color[:light]

    last_line_detail.hidden = last_branch?(index)

    self
  end

  private

  def last_branch?(index)
    @branch.brothers.count == index + 1
  end

  def color
    send "#{@branch.result}_colors"
  end
end
