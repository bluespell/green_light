class ProjectCellView < UIView
  include TimeHelper

  attr_accessor :project

  def configure(project)
    @project = project

    self.setBackgroundColor(@project.status_color[:background])

    # Project Name
    project_name = UILabel.alloc.initWithFrame([[20, 7],[222, 21]])
    project_name.font = UIFont.fontWithName("HelveticaNeue-Bold", size:16)
    project_name.setTextColor('4A4A4A'.to_color)
    project_name.text = @project.name
    self.addSubview(project_name)

    # Project Details
    project_details = UILabel.alloc.initWithFrame([[20, 32],[222, 21]])
    project_details.font = UIFont.fontWithName("HelveticaNeue", size: 14)
    project_details.setTextColor('4A4A4A'.to_color)
    project_details.text = detail_text
    self.addSubview(project_details)
  end

  private

  def detail_text
    return 'Building...' unless @project.last_build

    "Last build: #{time_ago_in_words(@project.last_build)}"
  end
end