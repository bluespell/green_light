# Represents the details of a project, like its branches, last build, status, etc
class ProjectDetailsController < UITableViewController
  extend IB

  attr_accessor :project

  # Sets the Navigation Bar title to be the project's name
  def viewDidLoad
    self.navigationItem.title = @project.name
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end
end