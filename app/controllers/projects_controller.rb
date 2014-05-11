class ProjectsController < UITableViewController
  extend IB
  include TimeHelper

  outlet :all_projects_button, UITabBarItem

  attr_accessor :projects, :selected_project

  def viewDidLoad
    # TODO: set some nice image for the button...
    all_projects_button.image = UIImage.imageNamed('menu-25')

    @projects = Project.all
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  # Returns a specific cell; reuses stuff
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    project = @projects[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)

    cell.setBackgroundColor(project.status_color)
    cell.textLabel.text = project.name

    detail_text = project.last_build ? "Last build: #{time_ago_in_words(project.last_build)}" : 'Building...'
    cell.detailTextLabel.text = detail_text
    cell
  end

  # Calls the ProjectDetailsController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier("push_project_details", sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end
end
