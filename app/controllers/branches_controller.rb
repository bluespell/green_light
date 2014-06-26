# Represents the details of a project, like its branches, last build, status, etc
class BranchesController < UITableViewController
  extend IB

  attr_accessor :project, :semaphore_id

  outlet :header, UIView
  outlet :bar_button, UIBarButtonItem
  outlet :project_details_table_view, UITableView

  def viewDidLoad
    self.semaphore_id = @project.semaphore_id
    RefreshControlHelper.configure(refreshControl, self, :refresh_projects)
  end

  def viewWillAppear(animated)
    setup_header
  end

  # Returns the number os cells (Number of project's branches)
  def tableView(tableView, numberOfRowsInSection: section)
    @project.branches.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    tableView.dequeueReusableCellWithIdentifier('branch_cell', forIndexPath: indexPath)
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

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    performSegueWithIdentifier('push_builds_list', sender: nil)
  end

  private

  def setup_header
    header.configure(@project)
  end

  def refresh_projects
    refreshControl.attributedTitle = RefreshControlHelper.configure_message('Syncing...')

    # FIXME: we can refactor here to avoid duplication
    # the only thing that is different from the other calls is the semaphore_id thing
    RefreshProjectsCommand.run(Token.value) do
      self.project = Project.where(:semaphore_id => semaphore_id).first
      refreshControl.attributedTitle = RefreshControlHelper.set_last_update
      refreshControl.endRefreshing
      tableView.reloadData
    end
  end
end
