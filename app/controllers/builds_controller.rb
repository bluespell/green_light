class BuildsController < UITableViewController

  def viewDidAppear(animated)
    RefreshControlHelper.configure(refreshControl, self, :refresh_builds)
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end

  private

  def refresh_builds
    RefreshControlHelper.trigger_refresh(refreshControl, cdq, tableView)
  end
end