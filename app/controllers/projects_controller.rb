class ProjectsController < UITableViewController
  extend IB

  attr_accessor :projects, :selected_project
  include TimeHelper

  # Outlets
  outlet :all_projects_button, UITabBarItem

  def viewDidLoad

    # TODO: set some nice image for the button...
    all_projects_button.image = UIImage.imageNamed('menu-25')

    if Persistence.exists?('projects')
      @projects = Project.initialize_from_json(Persistence.decode('projects'))
    end
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

    cell.setBackgroundColor(project.color) # This is actually transparent
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
