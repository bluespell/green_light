class BranchesHeaderView < UIView
  extend IB
  include ColorHelper, LayoutHelper

  attr_accessor :project

  outlet :project_name, UILabel
  outlet :last_build, UILabel
  outlet :project_status, UILabel
  outlet :number_of_branches, UILabel
  outlet :number_of_branches_failed, UILabel
  outlet :number_of_branches_passed, UILabel
  outlet :project_status_background, UIView

  def configure(project)
    @project = project

    project_name.text = project.name
    last_build.text = project.master_branch.human_building_date
    project_status.text = project.master_branch.result

    number_of_branches.text = project.branches.count.to_s
    number_of_branches_passed.text = project.passed_branches.count.to_s
    number_of_branches_failed.text = project.failed_branches.count.to_s

    project_status_background.setBackgroundColor send("#{project_status.text}_colors")[:strong]
    inset_shadow project_status_background
  end
end
