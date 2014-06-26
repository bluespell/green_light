class AuthenticationCommand
  def self.run(token, &block)
    SVProgressHUD.appearance.setHudBackgroundColor("F2F2E9".to_color)
    SVProgressHUD.showWithStatus("Loading", maskType: SVProgressHUDMaskTypeGradient)

    RemoteManager.object_manager.getObjectsAtPath(
      'projects.json',
      parameters: { auth_token: token },
      success: ->(operation, mapping_result) {

        # FIXME: this needs to go to a model `before_save` callback
        mapping_result.array.each do |project|
          project.last_build_cache = project.last_build
        end

        SVProgressHUD.showSuccessWithStatus "Success"

        block.call
      },
      failure: ->(operation, error) {
        SVProgressHUD.dismiss
        App.alert("Could not validate the token")
      }
    )
  end
end
