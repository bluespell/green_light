class FavoriteProjectsController < UITableViewController
  extend IB

  outlet :favorite_projects_button, UITabBarItem
  outlet :favorites_table_view, UITableView

  attr_accessor :projects, :selected_project, :last_update

  def viewWillAppear(animated)
    @projects = Project.favorites
  end

  def viewDidAppear(animated)
    if @projects.count == 0
      show_instructions
    else
      RefreshControlHelper.configure(refreshControl, self, :refresh_projects)
    end

    # Grand Central Dispatch (updates favorite projects)
    Dispatch::Queue.main.async { favorites_table_view.reloadData }
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cell_id = 'project_cell'

    cell = tableView.dequeueReusableCellWithIdentifier(cell_id) || begin
      ProjectCell.alloc.init
    end

    cell.configure @projects[indexPath.row]
  end

  # Calls the BranchesController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier('push_branches_from_fav', sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
    segue.destinationViewController.bar_button.title = navigationItem.title
  end

  private

  def show_instructions
    alert = BW::UIAlertView.new({ title: 'Favorite a project by tapping its star :)',
                                  buttons: ['OK'],
                                }) { select_projects_tab }
    alert.show
  end

  def select_projects_tab
    tabBarController.setSelectedIndex(0)
  end

  def refresh_projects
     RefreshControlHelper.trigger_refresh(refreshControl, cdq, tableView)
  end
end
