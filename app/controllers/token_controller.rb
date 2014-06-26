class TokenController < UIViewController
  extend IB

  outlet :token_field, UITextField

  def viewDidLoad
    token_field.text = Token.first.value unless Token.count == 0
    token_field.delegate = self
    performSegueWithIdentifier("push_projects", sender: nil) if Project.count > 0
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  def login(sender)
    return App.alert("The token can't be empty") if token_field.text.empty?

    token_field.resignFirstResponder

    AuthenticationCommand.run(token_field.text) do
      update_token
      performSegueWithIdentifier("push_projects", sender: sender)
    end
  end

  private

  def open_token_instructions
    UIApplication.sharedApplication.openURL NSURL.URLWithString 'https://semaphoreapp.com/docs/api_authentication.html'
  end

  def update_token
    if (Token.count == 0)
      Token.create(value: token_field.text)
    else
      Token.first.value = token_field.text
    end

    cdq.save
  end
end
