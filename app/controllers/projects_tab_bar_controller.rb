# Holds "All Projects" ()ProjectsController) and "Favorite Projects" (FavoriteProjectsController)
# Has a back button that shows the TokenController
class ProjectsTabBarController < UITabBarController

  attr_accessor :view_title

  def viewDidLoad
    self.delegate = self # So it can responde to 'didSelectViewController', for example
    self.navigationItem.title = view_title # This comes from the Token Controller
  end

  # Called each time a tab item is selected (at the bottom of the screen)
  def tabBarController(tabBarController, didSelectViewController: viewController)
    self.navigationItem.title = viewController.navigationItem.title
  end

  # Pops the current view and gets back to the previous one
  def back(sender)
    self.navigationController.popViewControllerAnimated(true)
  end
end