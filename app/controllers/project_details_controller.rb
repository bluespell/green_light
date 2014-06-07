# Represents the details of a project, like its branches, last build, status, etc
class ProjectDetailsController < UITableViewController
  extend IB

  attr_accessor :project

  outlet :header, UIView
  outlet :bar_button, UIBarButtonItem
  outlet :project_details_table_view, UITableView

  def viewDidLoad
    self.refreshControl.addTarget self, action: :refresh_projects, forControlEvents: UIControlEventValueChanged
  end

  def viewWillAppear(animated)
    setup_header
  end

  # Returns the number os cells (Number of project's branches)
  def tableView(tableView, numberOfRowsInSection: section)
    @project.branches.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuse_identifier ||= 'branch_cell'
    tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    branch = @project.ordered_branches[indexPath.row]
    cell.configure branch, indexPath.row
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end

  def tableView(tableView, viewForHeaderInSection: section)
    return header
  end

  def tableView(tableView, heightForFooterInSection: section)
    0.01
  end

  private

  def setup_header
    header.configure(@project)
  end

  def refresh_projects
    ProjectUpdater.update!(cdq, { :success => lambda { Dispatch::Queue.main.async { project_details_table_view.reloadData } },
                                  :failure => lambda { App.alert("Could not refresh projects") },
                                  :done    => lambda { refreshControl.endRefreshing } })
  end
end
