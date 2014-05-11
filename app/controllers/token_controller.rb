class TokenController < UIViewController
  extend IB

  outlet :token_field, UITextField

  attr_reader :target_view_title

  def viewDidLoad
    token_field.delegate = self

    if Persistence.exists?('token')
      token_field.text = Persistence.read('token')

      # TODO: Set the view title to 'Favorites' if that's the case
      @target_view_title = 'Projects'
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

    token_field.resignFirstResponder
    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    # TODO: refactoring: single class to handle API calls
    Semaphore.login(token_field.text) do |response|
      if response.success?
        Persistence.write('token', token_field.text)
        ProjectsBuilder.build! response.object

        SVProgressHUD.showSuccessWithStatus "Success"

        performSegueWithIdentifier("push_projects", sender: sender)
      elsif response.failure?
        SVProgressHUD.dismiss
        App.alert("Could not validate the token")
      end
    end
  end

  # TODO hardcoding for testing purposes for now. Pass in real data later

  # The prepareForSegue method is called just before a segue is performed.
  # It allows passing data to the new view controller that is the segue’s destination.
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.view_title = target_view_title
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
