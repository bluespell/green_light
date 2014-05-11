class TokenController < UIViewController
  extend IB

  outlet :token_field, UITextField

  def viewDidLoad
    token_field.delegate = self

    if Persistence.exists?('token')
      token_field.text = Persistence.read('token')

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
    return App.alert("Your token can't be empty") if token_field.text.empty?

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
