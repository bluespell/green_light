# Holds "All Projects" (ProjectsController) and "Favorite Projects" (FavoriteProjectsController)
# Has a back button that shows the TokenController
class ProjectsTabBarController < UITabBarController
  def viewDidLoad
    self.delegate = self # So it can responde to 'didSelectViewController', for example
    self.navigationItem.title = view_title

    # TODO: refactor me!
    # All Projects View (Index 0)
    self.viewControllers[0].all_projects_button.image = UIImage.imageNamed('menu-25')
    Project.count > 0 ?
        self.viewControllers[0].tabBarItem.setBadgeValue(Project.count.to_s) :
        self.viewControllers[0].tabBarItem.setBadgeValue(nil)

    # Favorites View (Index 1)
    if Project.any_favorite?
      self.viewControllers[1].tabBarItem.setBadgeValue(Project.favorites.count.to_s)
      self.selectedIndex = 1
    else
      self.viewControllers[1].tabBarItem.setBadgeValue(nil)
    end
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

end
