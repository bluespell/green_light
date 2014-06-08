class RefreshControlHelper

  # Configures a Refresh Control with common options:
  #  - Initial Title
  #  - Target (a TableViewController)
  #  - Action (the method that will handle the refresh in the TableViewController)
  def self.configure(refreshControl, target, action)
    refreshControl.attributedTitle = configure_message('Pull down to refresh')
    refreshControl.addTarget target, action: action, forControlEvents: UIControlEventValueChanged

    # iOS 7 bug:
    # http://stackoverflow.com/questions/19121276/uirefreshcontrol-incorrect-title-offset-during-first-run-and-sometimes-title-mis
    Dispatch::Queue.main.async {
      refreshControl.beginRefreshing
      refreshControl.endRefreshing
    }
  end

  # Triggers the refresh and configure the given refresh control
  def self.trigger_refresh(refreshControl, cdq, tableView)
    refreshControl.attributedTitle = configure_message('Syncing...')

    ProjectUpdater.update!(cdq, { :success => lambda { Dispatch::Queue.main.async { tableView.reloadData } },
                                  :failure => lambda { App.alert('Could not refresh projects') },
                                  :done    => lambda {
                                    refreshControl.attributedTitle = RefreshControlHelper.set_last_update
                                    refreshControl.endRefreshing } } )
  end

  def self.set_last_update
    formatter = NSDateFormatter.alloc.init
    formatter.setDateFormat 'MMM d, h:mm a'
    configure_message (NSString.stringWithFormat "Last updated on #{formatter.stringFromDate NSDate.date}")
  end

  def self.configure_message(message)
    range = [0, message.length]
    custom_message = NSMutableAttributedString.alloc.initWithString(message)
    custom_message.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: range)
    custom_message.addAttribute(NSForegroundColorAttributeName, value: ColorHelper.refresh_control_color, range: range)
  end
end