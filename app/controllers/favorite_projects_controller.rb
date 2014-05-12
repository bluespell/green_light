# Class to hold the favorite projects
class FavoriteProjectsController < UITableViewController
  extend IB

  outlet :favorite_projects_button, UITabBarItem

  attr_accessor :favorite_projects

  def viewDidLoad
    @favorite_projects = Project.favorites
  end

  # TODO: put projects in rows
end