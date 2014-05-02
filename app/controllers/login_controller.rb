class LoginController < UIViewController
  extend IB

  # Outlets
  outlet :token_field, UITextField

  def viewDidLoad
    token_field.delegate = self
  end

  # Hide the keyboard when "Done" is pressed
  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  # Call Semaphore passing in the token
  def login(sender)

    # TODO check if token isn't nil
    # TODO verificar o json retornado
    # TODO change svprogresshud background
    # TODO caga tudo quando eh emoji (bloquear emoji?)
    # TODO subir tela quando digita o token
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    Semaphore.login(token_field.text) do |response|
      #puts response.body.to_str
      SVProgressHUD.dismiss
    end
  end
end