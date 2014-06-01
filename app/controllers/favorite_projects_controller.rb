class FavoriteProjectsController < UITableViewController
  extend IB

  outlet :favorite_projects_button, UITabBarItem
  outlet :favorites_table_view, UITableView

  attr_accessor :projects, :selected_project

  def viewDidLoad
    self.refreshControl.addTarget self, action: :refresh_projects, forControlEvents: UIControlEventValueChanged
  end

  def viewWillAppear(animated)
    @projects = Project.favorites
  end

  def viewDidAppear(animated)
    show_instructions if @projects.count == 0

    # Grand Central Dispatch (updates favorite projects)
    Dispatch::Queue.main.async { favorites_table_view.reloadData }
  end

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
    performSegueWithIdentifier('push_project_details_from_fav', sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end

  private

  def show_instructions
    App.alert("Favorite a project by tapping its star :)")
  end

  def refresh_projects
    # Semaphore.projects(TokenOld.value) do |response|
    #
    #   if response.success?
    #     # FIXME should update only the project branches -- the way it is now, we lost the favorite projects
    #     ProjectsBuilder.build! response.object
    #     @projects = ProjectOld.favorites
    #     Dispatch::Queue.main.async { favorites_table_view.reloadData }
    #
    #   elsif response.failure?
    #     App.alert("Could not refresh projects")
    #   end
    # end

    self.refreshControl.endRefreshing
  end
end
