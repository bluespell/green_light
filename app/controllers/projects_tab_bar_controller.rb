# Holds "All Projects" (ProjectsController) and "Favorite Projects" (FavoriteProjectsController)
# Has a back button that shows the TokenController
class ProjectsTabBarController < UITabBarController

  # TODO: if the "TOKEN" button is pressed, show a message to users:
  # Are you sure you want to proceed? All projects will be lost or something

  def viewDidLoad
    self.delegate = self
    self.navigationItem.title = view_title
    self.viewControllers[0].all_projects_button.image = UIImage.imageNamed('menu-25')

    self.selectedIndex = 1 if Project.any_favorite?

    set_badge_count
  end

  # Called each time a tab item is selected (at the bottom of the screen)
  def tabBarController(tabBarController, didSelectViewController: viewController)
    self.navigationItem.title = viewController.navigationItem.title
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end

  def view_title
    Project.any_favorite? ? 'Favorites' : 'All Projects'
  end

  # TODO NSNotificationCenter
  def set_badge_count
    self.viewControllers[0].tabBarItem.setBadgeValue project_counter(:all)
    self.viewControllers[1].tabBarItem.setBadgeValue project_counter(:favorites)
  end

  private

  def project_counter(method)
    result = Project.send method

    result.count > 0 ? result.count.to_s : nil
  end
end
