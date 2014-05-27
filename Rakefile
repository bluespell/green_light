# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'yaml'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'green_light'
  app.device_family = [:iphone, :ipad]

  # iOS 7 > 75% adoption (January, 2014)
  app.sdk_version = '7.1'
  app.deployment_target = '7.0'

  app.pods do
    dependency 'SVProgressHUD', '~> 1.0'
    dependency 'YIInnerShadowView', '~> 1.0.1'
    dependency 'MHPrettyDate', '~> 1.1.1'
    dependency 'GBDeviceInfo', '~> 2.2.6'
  end
end
