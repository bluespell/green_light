class LoginController < UIViewController
  extend IB

  # Outlets
  outlet :token_field, UITextField

  def viewDidLoad
    token_field.delegate = self
  end

  def textFieldDidBeginEditing(textField)
    # Screen goes up when the keyboard appears
    animateTextField(textField, true)
  end

  def textFieldDidEndEditing(textField)
    # Screen goes down when the keyboard disappears
    animateTextField(textField, false)
  end

  # Slides the screen up or down
  def animateTextField(textField, up)
    movementDistance = 80 # Tweak as needed
    movementDuration = 0.3 # Tweak as needed
    movement = (up ? - movementDistance : movementDistance)

    UIView.beginAnimations("anim", context: nil)
    UIView.animationBeginsFromCurrentState = true
    UIView.animationDuration = movementDuration
    self.view.frame = CGRectOffset(self.view.frame, 0, movement)
    UIView.commitAnimations
  end

  def textFieldShouldReturn(textField)
    # Hide the keyboard when "Done" is pressed
    textField.resignFirstResponder
  end

  # Call Semaphore passing in the token
  def login(sender)

    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    Semaphore.login(token_field.text) do |response|
      #puts response.body.to_str

      # Only uncomment the SEGUE on line 53 if:

      # TODO the token is NOT nil
      # TODO the JSON returned is OK (has projects or something)

      # performSegueWithIdentifier("push_projects", sender: sender)

      # For future reference (how to pass data from a controller to another, like a parsed JSON, for example)
      # "The prepareForSegue method is called just before a segue is performed and allows you to pass variables to the
      # new view controller that is the segue’s destination"

      SVProgressHUD.dismiss
    end
  end
end