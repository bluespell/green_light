class FavoriteProjectsController < UITableViewController
  extend IB

  outlet :favorite_projects_button, UITabBarItem

  attr_accessor :favorite_projects, :selected_project

  def viewDidLoad
    @favorite_projects = Project.favorites.to_a
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @favorite_projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "project_cell"
    #TODO: reuse cells
    #cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= ProjectCellBuilder.new(:project => @favorite_projects[indexPath.row], :reuse_identifier => @reuseIdentifier).build_cell
  end

  # Calls the ProjectDetailsController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @favorite_projects[indexPath.row]
    performSegueWithIdentifier("push_project_details_from_all", sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end
end