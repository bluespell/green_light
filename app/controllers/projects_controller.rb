class ProjectsController < UIViewController
  extend IB

  outlet :back_button, UIBarButtonItem

  def back sender
    self.navigationController.popViewControllerAnimated(true)
  end

end