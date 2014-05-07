class LoginController < UIViewController
  extend IB

  attr_reader :projects

  # Outlets
  outlet :token_field, UITextField

  def viewDidLoad
    token_field.delegate = self

    if Preferences.exists?('token')
      token_field.text = Preferences.read('token')
      performSegueWithIdentifier("push_projects", sender: nil)
    end
  end

  def textFieldDidBeginEditing(textField)
    # Screen goes up when the keyboard appears
    animate_text_field textField, :direction => :up
  end

  def textFieldDidEndEditing(textField)
    # Screen goes down when the keyboard disappears
    animate_text_field textField, :direction => :down
  end

  def textFieldShouldReturn(textField)
    # Hide the keyboard when "Done" is pressed
    textField.resignFirstResponder
  end

  def login(sender)
    if token_field.text.empty?
      App.alert("Your token can't be empty")
      return
    end

    @projects = []
    token_field.resignFirstResponder
    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    # TODO: refactoring: single class to handle API calls
    Semaphore.login(token_field.text) do |response|
      if response.success?
        Preferences.write('token', token_field.text)
        Preferences.encode('projects', response.object)

        SVProgressHUD.showSuccessWithStatus "Success"

        performSegueWithIdentifier("push_projects", sender: sender)
      elsif response.failure?
        #SVProgressHUD.showErrorWithStatus "Error"
        SVProgressHUD.dismiss
        App.alert("Could not validate the token")
      end
    end
  end

  # TODO hardcoding for testing purposes for now. Pass in real data later

  # The prepareForSegue method is called just before a segue is performed.
  # It allows passing data to the new view controller that is the segue’s destination.
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.projects = @projects
  end

  private

  def animate_text_field(text_field, opts={})
    distance  = opts.fetch :distance, 80
    duration  = opts.fetch :duration, 0.3
    direction = opts.fetch :direction, :up

    distance *= (direction == :up ? -1 : 1)

    UIView.beginAnimations("anim", context: nil)
    UIView.animationBeginsFromCurrentState = true
    UIView.animationDuration = duration
    self.view.frame = CGRectOffset(self.view.frame, 0, distance)
    UIView.commitAnimations
  end
end
