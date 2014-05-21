class ProjectCell < UITableViewCell
  extend IB
  include ColorHelper

  outlet :project_name, UILabel
  outlet :project_details, UILabel
  outlet :favorite_button, UIButton

  attr_accessor :project, :selected_background_view_color

  def configure(project)
    @project = project

    # Cell selected color
    @selected_background_view_color = UIView.alloc.init
    @selected_background_view_color.setBackgroundColor cell_color[:medium]
    setSelectedBackgroundView @selected_background_view_color

    # Cell background color
    setBackgroundColor cell_color[:light]

    project_name.text = project.name
    project_details.text = project.master_branch.human_building_date

    configure_favorite_button

    self
  end

  # Handles the interaction with the favorite button
  def handle_favorite
    @project.toggle_favorite
    configure_favorite_button

    # superview = UITableViewWrapperView
    # .superview = UITableView
    # .dataSource = ProjectsController / FavoriteProjectsController
    if parent_controller.is_a?(FavoriteProjectsController)
      parent_controller.projects = Project.favorites
      Dispatch::Queue.main.async { superview.superview.reloadData }
    end

    parent_controller.tabBarController.set_badge_count
  end

  private

  def parent_controller
    superview.superview.dataSource
  end

  def configure_favorite_button
    favorite_button.setImage(UIImage.imageNamed(favorite_image), forState: UIControlStateNormal)
  end

  def favorite_image
    @project.favorite ? 'star-40-green' : 'star-40'
  end

  def cell_color
    send "#{@project.status}_colors"
  end
end
