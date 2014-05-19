class ProjectDetailsHeaderView < UIView
  extend IB
  include TimeHelper

  outlet :project_name, UILabel
  outlet :last_build, UILabel
  outlet :project_status, UILabel
  outlet :number_of_branches, UILabel
  outlet :number_of_branches_failed, UILabel
  outlet :number_of_branches_passed, UILabel
  outlet :project_status_background, UIView

  def configure(project)
    project_name.text = project.name
    last_build.text = time_ago_in_words(project.last_build)
    project_status.text = project.master_branch.result

    number_of_branches.text = project.branches.count.to_s
    number_of_branches_passed.text = project.passed_branches.count.to_s
    number_of_branches_failed.text = project.failed_branches.count.to_s

    if(project.master_branch.failed?)
      project_status_background.setBackgroundColor('FF0000'.to_color)
    elsif(project.master_branch.pending?)
      project_status_background.setBackgroundColor('DDEFF8'.to_color)
    else
      project_status_background.setBackgroundColor('59AF00'.to_color)
    end
  end
end