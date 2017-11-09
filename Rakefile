# -*- ruby -*-
# Release:
# See README.rdoc.releasing

require 'rubygems'
require 'hoe'

# rubocop:disable Metrics/LineLength
############################################# DEVELOPING ZONE #########################################################
Hoe.plugin :bundler
Hoe.plugin :doofus
Hoe.plugin :git
Hoe.plugin :manns
Hoe.plugin :rdoc
Hoe.plugin :reek
Hoe.plugin :rubocop
Hoe.plugin :rubygems
Hoe.plugin :travis
Hoe.plugin :version


Hoe.spec 'publican_creators' do
  developer('Sascha Manns', 'Sascha.Manns@mailbox.org')
  license 'GPL-3.0' # this should match the license in the README
  require_ruby_version '>= 2.2.0'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation *** Please file bugreports and feature requests on: https://bugs.launchpad.net/publicancreators'

  dependency 'nokogiri', '~> 1.8'
  dependency 'parseconfig', '~> 1.0'
  dependency 'rainbow', '~> 2.2'
  dependency 'notifier', '~> 0.5'

  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['hoe-bundler', '~> 1.3']
  extra_dev_deps << ['hoe-doofus', '~> 1.0']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 1.6']
  extra_dev_deps << ['hoe-reek', '~> 1.2']
  extra_dev_deps << ['hoe-rubocop', '~> 1.0']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe', '~> 3.16']
  extra_dev_deps << ['rake', '~> 12.2']
  extra_dev_deps << ['rdoc', '~> 5.1']
  extra_dev_deps << ['bundler', '~> 1.16']
  extra_dev_deps << ['rspec', '~> 3.7']
  extra_dev_deps << ['rubocop', '~> 0.51']
end

###################################### SETUP ZONE #####################################################################

require 'etc'
require 'fileutils'
desc 'Create Desktop files'
task :create_desktop_cre do
  home = Dir.home
  prefix = "#{home}/.rvm/rubies/default"
  datadir = "#{prefix}/share"
  publicancre = "#{home}/.local/share/applications/publicancreators.desktop"
  publicancreico = "#{datadir}/publican_creators/publican.png"
  system("sudo rm #{publicancre}") if File.exists?(publicancre)
  puts 'Creating Desktop file for PublicanCreators'.color(:yellow)
  FileUtils.touch "#{publicancre}"
  File.write "#{publicancre}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=publican_creators.rb
Icon=#{publicancreico}
EOF
end

require 'etc'
require 'fileutils'
desc 'Create publicancreators-rev.desktop'
task :create_desktop_rev do
  home = Dir.home
  prefix = "#{home}/.rvm/rubies/default"
  datadir = "#{prefix}/share"
  publicanrev = "#{home}/.local/share/applications/publicancreators-rev.desktop"
  publicanrevico = "#{datadir}/publican_creators/publican-revision.png"
  system("sudo rm #{publicanrev}") if File.exist?(publicanrev)
  puts 'Creating Desktop file for PublicanCreatorsRevision'.color(:yellow)
  FileUtils.touch "#{publicanrev}"
  File.write "#{publicanrev}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreatorsRevision
Exec=revision_creator.rb
Icon=#{publicanrevico}
EOF
end

require 'fileutils'
desc 'Backup config  file'
task :backup_config do
  home = Dir.home
  prefix = "#{home}/.publican_creators"
  from = 'publicancreators.cfg'
  to = 'publicancreators.bak'
  if File.exist?("#{prefix}/#{from}")
    FileUtils.cd(prefix) do
      FileUtils.cp(from, to)
    end
  end
end

desc 'Run setup'
task :setup => [:create_desktop_cre, :create_desktop_rev, :backup_config] do
  system('setup.rb uninstall --force')
  system('setup.rb config --sysconfdir=$HOME/.manns_shared')
  system('setup.rb install')
end
# vim: syntax=ruby
