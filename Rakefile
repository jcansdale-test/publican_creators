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
desc 'Install Icons'
task :install_icons do
  xdg = XDG::Environment.new
  data_xdg = xdg.data_home
  install_path = "#{data_xdg}/icons/"
  FileUtils.mkdir(install_path) unless File.exist?(install_path)
  from_publican = 'data/publican_creators/publican.png'
  from_publican_revision = 'data/publican_creators/publican-revision.png'
  FileUtils.cp(from_publican, install_path)
  FileUtils.cp(from_publican_revision, install_path)
  puts 'Installed icons'
end

require 'fileutils'
require 'xdg'
desc 'Install config'
task :install_config do
  xdg = XDG::Environment.new
  sys_xdg = xdg.config_home
  from = 'etc/publicancreators.cfg'
  sysconf_dir = "#{sys_xdg}/publican_creators"
  FileUtils.mkdir(sysconf_dir) unless File.exist?(sysconf_dir)
  FileUtils.cp(from, sysconf_dir)
end

require 'fileutils'
require 'xdg'
desc 'Create Desktop files'
task :create_desktop_cre do
  xdg = XDG::Environment.new
  sys_xdg = xdg.config_home
  data_xdg = xdg.data_home
  publicancre = "#{data_xdg}/applications/publicancreators.desktop"
  publicancreico = "#{data_xdg}/icons/publican.png"
  FileUtils.rm(publicancre) if File.exist?(publicancre)
  puts 'Creating Desktop file for publican_creators'.color(:yellow)
  FileUtils.touch publicancre.to_s
  File.write publicancre.to_s, <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=publican_creators
Exec=publican_creators.rb
Icon=#{publicancreico}
EOF
end

require 'xdg'
require 'fileutils'
desc 'Create publicancreators-rev.desktop'
task :create_desktop_rev do
  xdg = XDG::Environment.new
  sys_xdg = xdg.config_home
  data_xdg = xdg.data_home
  publicanrev = "#{data_xdg}/applications/publicancreators-rev.desktop"
  publicanrevico = "#{data_xdg}/icons/publican-revision.png"
  FileUtils.rm(publicanrev) if File.exist?(publicanrev)
  puts 'Creating Desktop file for Revision updater'.color(:yellow)
  FileUtils.touch publicanrev.to_s
  File.write publicanrev.to_s, <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=revision_creator
Exec=revision_creator.rb
Icon=#{publicanrevico}
EOF
end

desc 'Run setup'
task setup: %i[install_icons install_config create_desktop_cre create_desktop_rev] do
  puts 'Setup finished'
end
# vim: syntax=ruby
