class ProjectsController < UITableViewController
  extend IB

  outlet :all_projects_button, UITabBarItem
  outlet :projects_table_view, UITableView

  attr_accessor :projects, :selected_project

  def viewWillAppear(animated)
    update_projects
  end

  def update_projects
    # FIXME: Uninstall the app, run it. The order method is exploding for some reason
    @projects = Project.ordered_by_last_build
    projects_table_view.reloadData
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuse_identifier ||= 'project_cell'

    cell = tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
    cell.configure(@projects[indexPath.row])
  end

  # Calls the ProjectDetailsController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier('push_project_details_from_all', sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end
end
