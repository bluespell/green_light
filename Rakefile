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

  app.pods do
    dependency 'SVProgressHUD', '~> 1.0'
    dependency 'DateTools', '~> 1.2.0'
  end
end
