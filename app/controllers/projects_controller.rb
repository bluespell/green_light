class ProjectsController < UITableViewController
  extend IB

  include TimeHelper

  attr_accessor :projects

  def viewDidLoad
    if Persistence.exists?('projects')
      @projects = Project.initialize_from_json(Persistence.decode('projects'))
    end
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  # Returns a specific cell; reuses stuff
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    project = @projects[indexPath.row]

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)

    cell.setBackgroundColor(project.color) # This is actually transparent
    cell.textLabel.text = project.name
    cell.detailTextLabel.text = "Last build: #{time_ago_in_words(project.last_build)}"
    cell
  end

  # Pops the current view and gets back to the previous one (LoginController)
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end
end
