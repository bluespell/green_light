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
  
  app.frameworks += [ 'CoreData' ]

  app.icons = %w(AppIcon29x29.png, AppIcon29x29@2x.png, AppIcon40x40.png, AppIcon40x40@2x.png, AppIcon50x50.png, AppIcon50x50@2x.png, AppIcon57x57.png, AppIcon57x57@2x.png, AppIcon60x60.png, AppIcon60x60@2x.png, AppIcon72x72.png, AppIcon72x72@2x.png, AppIcon76x76.png, AppIcon76x76@2x.png)

  app.pods do
    dependency 'SVProgressHUD', '~> 1.0'
    dependency 'YIInnerShadowView', '~> 1.0.1'
    dependency 'GBDeviceInfo', '~> 2.2.6'
    dependency 'PrettyTimestamp', '~> 1.1'
  end
end
