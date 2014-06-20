class BuildsController < UITableViewController
  extend IB

  outlet :header, UIView

  def viewDidAppear(animated)
    RefreshControlHelper.configure(refreshControl, self, :refresh_builds)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    # builds
    15
  end

  def tableView(tableView, heightForHeaderInSection: section)
    60
  end

  def tableView(tableView, viewForHeaderInSection: section)
    return header
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuse_identifier ||= 'build_cell'
    tableView.dequeueReusableCellWithIdentifier(@reuse_identifier)
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    # build = ?
    cell.configure 'build'
  end

  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end

  private

  def refresh_builds
    RefreshControlHelper.trigger_refresh(refreshControl, cdq, tableView)
  end
end