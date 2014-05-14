class ProjectsController < UITableViewController
  extend IB

  outlet :all_projects_button, UITabBarItem

  attr_accessor :projects, :selected_project

  def viewDidLoad
    @projects = Project.ordered_by_last_build
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuse_identifier ||= "project_cell"
    project = @projects[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
    cell.configure(project)
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
