class TokenController < UIViewController
  extend IB

  outlet :token_field, UITextField

  def viewDidLoad
    token_field.text = Token.value
    token_field.delegate = self

    performSegueWithIdentifier("push_projects", sender: nil) unless token_field.text.empty?
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  def login(sender)
    return App.alert("The token can't be empty") if token_field.text.empty?

    token_field.resignFirstResponder

    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    # TODO: refactoring: single class to handle API calls
    Semaphore.login(token_field.text) do |response|
      if response.success?
        Token.create(:value => token_field.text)
        ProjectsBuilder.build! response.object

        SVProgressHUD.showSuccessWithStatus "Success"

        performSegueWithIdentifier("push_projects", sender: sender)
      elsif response.failure?
        SVProgressHUD.dismiss
        App.alert("Could not validate the token")
      end
    end
  end

  def open_token_instructions
    UIApplication.sharedApplication.openURL NSURL.URLWithString 'https://semaphoreapp.com/docs/api_authentication.html'
  end
end
