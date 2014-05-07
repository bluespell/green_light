class ProjectsController < UITableViewController
  extend IB

  attr_accessor :projects

  def viewDidLoad
    if Preferences.exists?('projects')
      @projects = Project.initialize_from_json(Preferences.decode('projects'))
    end
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  # Returns a specific cell; reuses stuff
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(
        UITableViewCellStyleDefault,
        reuseIdentifier:@reuseIdentifier
    )

    cell.backgroundColor = UIColor.clearColor # This is actually transparent
    cell.textLabel.text = @projects[indexPath.row].name
    cell
  end

  # Pops the current view and gets back to the previous one (LoginController)
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end
end
