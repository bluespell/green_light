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

  private

  def load_model_data
    Project.deserialize_from_file "projects.dat"
    Branch.deserialize_from_file "branches.dat"
    Token.deserialize_from_file "tokens.dat"
  end
end
