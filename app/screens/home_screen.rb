class HomeScreen < PM::Screen
  attr_accessor :submit_button, :email_field, :token_field

  title "Login"

  stylesheet :login_screen

  layout :screen do
    subview(UILabel, :email_label)
    subview(UILabel, :token_label)

    self.email_field   = subview(UITextField, :email_field)
    self.token_field   = subview(UITextField, :token_field)
    self.submit_button = subview(UIButton, :submit_button)

    self.email_field.delegate = self
    self.token_field.delegate = self
  end

  def on_appear
    @submit_button.when(UIControlEventTouchUpInside) { login }
  end

  def login
    SVProgressHUD.showWithStatus("Loading", maskType:SVProgressHUDMaskTypeGradient)

    Semaphore.login(@token_field.text) do |response|
      puts response.body.to_str
      SVProgressHUD.dismiss

    end
  end

  def textFieldShouldReturn(text_field)
    if text_field == email_field
      token_field.becomeFirstResponder
    else
      text_field.resignFirstResponder
    end

    true
  end
end
