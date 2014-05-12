# Class to hold the favorite projects
class FavoriteProjectsController < UITableViewController
  extend IB

  outlet :favorite_projects_button, UITabBarItem

  attr_accessor :favorite_projects

  def viewDidLoad
    # TODO: get from model
    @favorite_projects = []
    # Add a nice badge to this tab bar item
    @favorite_projects.count > 1 ? self.tabBarItem.setBadgeValue(@favorite_projects.count.to_s) : self.tabBarItem.setBadgeValue(nil)
  end
end