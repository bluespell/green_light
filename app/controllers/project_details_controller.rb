# Represents the details of a project, like its branches, last build, status, etc
class ProjectDetailsController < UIViewController
  extend IB

  attr_accessor :project

  outlet :header, UIView

  def viewWillAppear(animated)
    setup_header
  end

  # Returns the number os cells (Number of project's branches)
  def tableView(tableView, numberOfRowsInSection: section)
    @project.branches.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    reuse_identifier ||= 'branch_cell'
    branch = @project.branches.to_a[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier(reuse_identifier)
    cell.configure branch, indexPath.row
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end

  private

  def setup_header
    @header.configure(@project)
  end
end