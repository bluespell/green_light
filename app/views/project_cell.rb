class ProjectCell < UITableViewCell
  extend IB
  include TimeHelper

  outlet :project_name, UILabel
  outlet :project_details, UILabel
  outlet :favorite_button, UIButton

  attr_accessor :project, :selected_background_view_color

  def configure(project)
    @project = project

    configure_cell_colors
    configure_cell_labels
    configure_favorite_button

    self
  end

  # Handles the interaction with the favorite button
  def handle_favorite
    @project.favorite ? @project.favorite = false : @project.favorite = true
    configure_favorite_button
  end

  private

  def configure_cell_colors
    # Cell selected color
    @selected_background_view_color ||= UIView.alloc.init
    @selected_background_view_color.setBackgroundColor(@project.status_color[:foreground])
    self.setSelectedBackgroundView(@selected_background_view_color)

    # Cell background color
    self.setBackgroundColor(@project.status_color[:background])
  end

  def configure_cell_labels
    project_name.text = @project.name
    project_details.text = detail_text
  end

  def detail_text
    return 'Building...' unless @project.last_build

    "Last build: #{time_ago_in_words(@project.last_build)}"
  end

  def configure_favorite_button
    @project.favorite ?
        favorite_button.setImage(UIImage.imageNamed('star-40-green'), forState: UIControlStateNormal) :
        favorite_button.setImage(UIImage.imageNamed('star-40'), forState: UIControlStateNormal)
  end
end