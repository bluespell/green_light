class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    load_model_data

    # Storyboard instance
    storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle: nil)

    # Alloc Window and associate the Storyboard
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible

    true
  end

  def applicationDidEnterBackground(application)
    write_model_data
  end

  private

  def projects
    { Project => "projects.dat", Branch => "branches.dat", Token => "tokens.dat" }
  end

  def load_model_data
    projects.each { |project, file| project.deserialize_from_file file }
  end

  def write_model_data
    projects.each { |project, file| project.serialize_to_file file }
  end
end
