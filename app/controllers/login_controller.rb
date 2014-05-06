class LoginController < UIViewController
  extend IB

  # Outlets
  outlet :token_field, UITextField

  def viewDidLoad
    token_field.delegate = self
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

  # Call Semaphore passing in the token
  def login(sender)
    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    Semaphore.login(token_field.text) do |response|
      #puts response.body.to_str

      # TODO the token is NOT nil
      # TODO the JSON returned is OK (has projects or something)

      performSegueWithIdentifier("push_projects", sender: sender)

      SVProgressHUD.dismiss
    end
  end

  # TODO hardcoding for testing purposes for now. Pass in real data later

  # The prepareForSegue method is called just before a segue is performed.
  # It allows passing data to the new view controller that is the segue’s destination.
  def prepareForSegue(segue, sender: sender)
    segue.destinationViewController.projects = [
        Project.new("almoxarifado", "passed"),
        Project.new("compras", "passed"),
        Project.new("unico", "failed"),
        Project.new("folha", "building"),
        Project.new("frotas", "passed"),
        Project.new("matias_viado", "failed")
    ]
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
