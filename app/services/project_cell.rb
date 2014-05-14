class ProjectCell < UITableViewCell
  extend IB
  include TimeHelper

  attr_accessor :project

  outlet :project_title, UILabel
  outlet :project_details, UILabel

  def configure(project)
    @project = project

    @project_title.text = project.name
    @project_details.text = detail_text

    configure_cell_colors
  end

  private

  def detail_text
    return 'Building...' unless @project.last_build

    "Last build: #{time_ago_in_words(@project.last_build)}"
  end

  def configure_cell_colors
    view = UIView.alloc.init
    view.setBackgroundColor("F2F2E9".to_color)
    self.selectedBackgroundView = view
    self.setBackgroundColor(@project.status_color[:foreground])
  end
end