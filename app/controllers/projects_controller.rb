class ProjectsController < UITableViewController
  extend IB
  include TimeHelper

  outlet :all_projects_button, UITabBarItem

  attr_accessor :projects, :selected_project

  def viewDidLoad
    @projects = Project.all
  end

  # Returns the number os cells
  def tableView(tableView, numberOfRowsInSection: section)
    @projects.count
  end

  # Returns a specific cell; reuses stuff
  # TODO: create a custom cell class to reuse
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    project = @projects[indexPath.row]

    cell ||= MCSwipeTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: @reuseIdentifier)

    detail_text = project.last_build ? "Last build: #{time_ago_in_words(project.last_build)}" : 'Building...'
    cell.detailTextLabel.text = detail_text

    cell.setBackgroundColor(project.status_color[:foreground])
    cell.textLabel.text = project.name

    # Configuring the views and colors.
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed('star-32'))
    image_view.contentMode = UIViewContentModeCenter

    # Changing the trigger percentage
    cell.firstTrigger = 0.25;
    cell.secondTrigger = 0.6;

    # Add to favorites
    cell.setSwipeGestureWithView(
        image_view,
        color: "#8DB53E".to_color,
        mode: MCSwipeTableViewCellModeSwitch,
        state: MCSwipeTableViewCellState1,
        completionBlock: -> (cell, state, mode) {
          project.favorite = true
          project.save
          # TODO: update badge number in FavoriteController
        }
    )

    # Remove to favorites
    cell.setSwipeGestureWithView(
        image_view,
        color: "#B13200".to_color,
        mode: MCSwipeTableViewCellModeSwitch,
        state: MCSwipeTableViewCellState2,
        completionBlock: -> (cell, state, mode) {
          project.favorite = false
          project.save
          # TODO: update badge number in FavoriteController
        }
    )

    cell.delegate = self
    cell
  end

  # Calls the ProjectDetailsController when a project is tapped (selected)
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @selected_project = @projects[indexPath.row]
    performSegueWithIdentifier("push_project_details_from_all", sender: nil)
  end

  # Set the tapped (selected) project in the destination controller
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.project = @selected_project
  end
end
