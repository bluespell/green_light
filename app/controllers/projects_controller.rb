class ProjectsController < UITableViewController
  extend IB
  include NsFetchedResultsHelper

  outlet :all_projects_button, UITabBarItem
  outlet :projects_table_view, UITableView

  attr_accessor :projects, :selected_project

  def collection
    @projects ||= Project.sort_by(:last_build_cache, order: :descending)
  end

  def viewDidLoad
    super

    setupNSFetchedResultsController

    RefreshControlHelper.configure(refreshControl, self, :refresh_projects)
  end

  def viewDidUnload
    super
    clearNSFetchedResultsController
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
    fetch_controller.sections[section].numberOfObjects
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    tableView.dequeueReusableCellWithIdentifier('project_cell', forIndexPath: indexPath)
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.configure fetch_controller.objectAtIndexPath(indexPath)
  end

  # Calls the BranchesController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = fetch_controller.objectAtIndexPath(indexPath)
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
