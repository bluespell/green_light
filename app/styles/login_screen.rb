Teacup::Stylesheet.new :login_screen do
  style :screen,
    backgroundColor: UIColor.whiteColor

  style :label,
    textAlignment: NSTextAlignmentLeft

  style :text_field,
    borderStyle: UITextBorderStyleRoundedRect,
    textAlignment: NSTextAlignmentCenter

  style :email_label, extends: :label,
    text: 'Enter your email:',
    constraints: [
      constrain_left(8),
      constrain(:width).equals(:superview, :width).minus(16),
      constrain(:top).equals(:superview, :bottom).times(0.5).minus(70)
    ]

  style :email_field, extends: :text_field,
    returnKeyType: UIReturnKeyNext,
    constraints: [
      constrain(:left).equals(:email_label, :left),
      constrain(:width).equals(:email_label, :width),
      constrain(:top).equals(:email_label, :bottom).plus(10)
    ]

  style :token_label, extends: :label,
    text: 'Enter your secret token:',
    constraints: [
      constrain(:left).equals(:email_label, :left),
      constrain(:width).equals(:email_label, :width),
      constrain(:top).equals(:email_field, :bottom).plus(20)
    ]

  style :token_field, extends: :text_field,
    returnKeyType: UIReturnKeyDone,
    constraints: [
      constrain(:left).equals(:email_label, :left),
      constrain(:width).equals(:email_label, :width),
      constrain(:top).equals(:token_label, :bottom).plus(10)
    ]

  style :submit_button,
    title: 'Submit',
    backgroundColor: UIColor.blackColor,
    textColor: UIColor.whiteColor,
    constraints: [
      constrain_left(8),
      constrain(:width).equals(:superview, :width).minus(16),
      constrain(:bottom).equals(:superview, :bottom).minus(15)
    ]

end
