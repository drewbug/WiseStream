# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'WiseStream'
  app.info_plist['UIBackgroundModes'] = ['audio']
  app.deployment_target = '6.1'
  app.frameworks << 'CoreMotion'
  app.pods { pod 'UI7Kit' }
end
