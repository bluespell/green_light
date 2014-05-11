# Class to hold the favorite projects
class FavoriteProjectsController < UITableViewController
  extend IB

  attr_accessor :favorite_projects

  def viewDidLoad
    # Add a nice badge to this tab bar item
    # @favorite_projects.count > 1 ? self.tabBarItem.setBadgeValue(@favorite_projects.count.to_s) : self.tabBarItem = nil
  end

  #Outlets
  outlet :favorite_projects_button, UITabBarItem
end