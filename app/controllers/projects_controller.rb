class ProjectsController < UITableViewController
  extend IB

  outlet :all_projects_button, UITabBarItem
  outlet :projects_table_view, UITableView

  attr_accessor :projects, :selected_project

  def viewDidLoad
    @projects = Project.ordered_by_last_build
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
    Semaphore.projects(Token.value) do |response|

      if response.success?
        # FIXME should update only the project branches -- the way it is now, we lost the favorite projects
        ProjectsBuilder.build! response.object
        @projects = Project.ordered_by_last_build
        Dispatch::Queue.main.async { projects_table_view.reloadData }

        self.refreshControl.endRefreshing

      elsif response.failure?
        App.alert("Could not refresh projects")
      end
    end
  end
end
