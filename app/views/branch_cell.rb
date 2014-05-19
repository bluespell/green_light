class BranchCell < UITableViewCell
  extend IB
  include TimeHelper

  attr_accessor :branch

  outlet :branch_name, UILabel
  outlet :last_build, UILabel
  outlet :branch_status, UILabel
  outlet :branch_status_background, UIView
  outlet :last_line_detail, UIView

  def configure(branch, index)
    @branch = branch

    branch_name.text = branch.name
    last_build.text = time_ago_in_words(branch.finished_at)
    branch_status.text = branch.result

    if (branch.failed?)
      branch_status_background.setBackgroundColor("FF0000".to_color)
      setBackgroundColor("F3E2D8".to_color)
    elsif (branch.pending?)
      branch_status_background.setBackgroundColor("DDEFF8".to_color)
      setBackgroundColor("EAF3F7".to_color)
    else
      branch_status_background.setBackgroundColor("59AF00".to_color)
      setBackgroundColor("EAF3D8".to_color)
    end

    last_branch?(index) ? last_line_detail.hidden = true : last_line_detail.hidden = false

    self
  end

  private

  def last_branch?(index)
    @branch.brothers.count == index + 1
  end
end