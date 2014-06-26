class AppDelegate
  include CDQ

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    cdq.setup

    RemoteManager.setup

    # Storyboard instance
    storyboard = UIStoryboard.storyboardWithName("Storyboard", bundle: nil)

    # Alloc Window and associate the Storyboard
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible

    true
  end
end
