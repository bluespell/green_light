class ProjectsController < UITableViewController
  extend IB

  outlet :all_projects_button, UITabBarItem
  outlet :projects_table_view, UITableView

  attr_accessor :projects, :selected_project

  def viewDidLoad
    @projects = Project.sort_by(:last_build_cache, order: :descending)
    self.refreshControl.addTarget self, action: :refresh_projects, forControlEvents: UIControlEventValueChanged
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
    reuse_identifier ||= 'project_cell'
    tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.configure @projects[indexPath.row]
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

  def refresh_projects
    ProjectUpdater.update!(cdq, { :success => lambda { Dispatch::Queue.main.async { projects_table_view.reloadData } },
                                  :failure => lambda { App.alert("Could not refresh projects") },
                                  :done    => lambda { refreshControl.endRefreshing } })
  end
end
