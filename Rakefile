# -*- ruby -*-
# Copyright (C) 2013-2018 Sascha Manns <Sascha.Manns@mailbox.org>
# Release:
# Pre-release:
#* update docs
#* Update copyright years if needed, in the following paths:
#  + lib/*
#* Check version in lib/hoe-reek.rb
#* Update History.rdoc & NEWS
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

require 'rubygems'
require 'hoe'

# rubocop:disable Metrics/LineLength
############################################# DEVELOPING ZONE #########################################################
Hoe.plugin :bundler
Hoe.plugin :git
Hoe.plugin :manns
Hoe.plugin :rdoc
Hoe.plugin :reek
Hoe.plugin :rubocop
Hoe.plugin :rubygems
Hoe.plugin :travis
Hoe.plugin :version

Hoe.spec 'publican_creators' do
  developer('Sascha Manns', 'Sascha.Manns@outlook.de')
  license 'GPL-3.0' # this should match the license in the README
  require_ruby_version '>= 2.3.0'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation *** Please file bugreports and feature requests on: https://github.com/saigkill/publican_creators/issues'

  dependency 'nokogiri', '~> 1.8'
  dependency 'parseconfig', '~> 1.0'
  dependency 'rainbow', '~> 3.0'
  dependency 'notifier', '~> 0.5'
  dependency 'xdg', '~> 2.2'

  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 2.1']
  extra_dev_deps << ['hoe-reek', '~> 1.2']
  extra_dev_deps << ['hoe-rubocop', '~> 1.0']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe', '~> 3.17']
  extra_dev_deps << ['rake', '~> 12.3']
  extra_dev_deps << ['rdoc', '~> 6.0']
  extra_dev_deps << ['bundler', '~> 1.16']
  extra_dev_deps << ['rspec', '~> 3.7']
  extra_dev_deps << ['rubocop', '~> 0.57']
end

###################################### SETUP ZONE #####################################################################

require 'fileutils'
require 'xdg'
desc 'Install Icons'
task :install_icons do
  data_xdg = XDG['DATA_HOME']
  install_path = "#{data_xdg}/icons/"
  FileUtils.mkdir(insttall_path) unless File.exist?(install_path)
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
  sys_xdg = XDG['CONFIG_HOME']
  from = 'etc/publicancreators.cfg'
  sysconf_dir = "#{sys_xdg}/publican_creators"
  FileUtils.mkdir(sysconf_dir) unless File.exist?(sysconf_dir)
  FileUtils.cp(from, sysconf_dir)
end

require 'fileutils'
require 'xdg'
desc 'Create Desktop files'
task :create_desktop_cre do
  sys_xdg = XDG['CONFIG_HOME']
  data_xdg = XDG['DATA_HOME']
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
  sys_xdg = XDG['CONFIG_HOME']
  data_xdg = XDG['DATA_HOME']
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
