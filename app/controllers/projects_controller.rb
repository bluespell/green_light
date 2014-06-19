class ProjectsController < UITableViewController
  extend IB

  outlet :all_projects_button, UITabBarItem
  outlet :projects_table_view, UITableView

  attr_accessor :projects, :selected_project

  def viewDidLoad
    @projects = Project.sort_by(:last_build_cache, order: :descending)
    RefreshControlHelper.configure(refreshControl, self, :refresh_projects)
  end

  def viewWillAppear(animated)
    tabBarController.navigationItem.title = 'Projects'
  end

  def viewDidAppear(animated)
    # Grand Central Dispatch (updates favorite projects)
    Dispatch::Queue.main.async { projects_table_view.reloadData }
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuse_identifier ||= 'project_cell'
    tableView.dequeueReusableCellWithIdentifier(@reuse_identifier)
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.configure @projects[indexPath.row]
  end

  # Calls the BranchesController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier('push_branches_from_all', sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
    segue.destinationViewController.bar_button.title = navigationItem.title
  end

  private

  def refresh_projects
    RefreshControlHelper.trigger_refresh(refreshControl, cdq, tableView)
  end
end
