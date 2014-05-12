class ProjectsController < UITableViewController
  extend IB
  include TimeHelper

  outlet :all_projects_button, UITabBarItem

  attr_accessor :projects, :selected_project

  def viewDidLoad
    all_projects_button.image = UIImage.imageNamed('menu-25')

    @projects = Project.all

    # Add a nice badge to this tab bar item
    @projects.count > 1 ? self.tabBarItem.setBadgeValue(@projects.count.to_s) : self.tabBarItem.setBadgeValue(nil)
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  # Returns a specific cell; reuses stuff
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    project = @projects[indexPath.row]

    cell ||= SWTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: @reuseIdentifier)

    detail_text = project.last_build ? "Last build: #{time_ago_in_words(project.last_build)}" : 'Building...'
    cell.detailTextLabel.text = detail_text

    cell.setBackgroundColor(project.status_color[:foreground])
    cell.textLabel.text = project.name
    cell.leftUtilityButtons = cell_left_buttons(project.status_color[:background])

    cell.delegate = self
    cell
  end

  def cell_left_buttons(background_color)
    buttons = []
    buttons.sw_addUtilityButtonWithColor(background_color, icon: UIImage.imageNamed('star-32'))
  end

  def swipeableTableViewCell(cell, didTriggerLeftUtilityButtonWithIndex: index)
    # TODO: verify if the STAR was pressed
    # TODO: update the cell project with favorite = true
    # TODO: update badge number in FavoriteController
  end

  # Calls the ProjectDetailsController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier("push_project_details_from_all", sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end
end
