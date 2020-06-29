# -*- ruby -*-
# Copyright (C) 2013-2018 Sascha Manns <Sascha.Manns@mailbox.org>
# Release:
# Pre-release:
#* update docs
#* Update copyright years if needed, in the following paths:
#  + lib/*
#* Check version in lib/hoe-reek.rb
#* Update CHANGELOG.md & NEWS
#* git:manifest
#* bundler:gemfile
#* bundler:gemfile_lock
# x64-mingw32
# x64-mswin32
# x86-mingw32
# x86-mswin32
# ruby
# x86_64-linux
#* bundle_audit:run
#* git -a -m "Anything"
#* git tag x.x.x

# Release:
#* Create Release in Github
#* rake release
#* send_email
#* clean_pkg

# Post-release:
#* Bump version
#* Add new Milestone on Github

###################################### SETUP ZONE #####################################################################

require 'fileutils'
require 'xdg'
desc 'Install config'
task :install_setup do
  xdg = XDG::Environment.new
  sys_xdg = xdg.config_home
  from = 'etc/publicancreators.cfg'
  sysconf_dir = "#{sys_xdg}/publican_creators"
  FileUtils.mkdir(sysconf_dir) unless File.exist?(sysconf_dir)
  FileUtils.cp(from, sysconf_dir)
end
# vim: syntax=ruby
