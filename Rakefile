# -*- ruby -*-
require 'bundler/gem_tasks'
require 'rubygems'

# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

task :default do
  puts 'Using the default task'
end

# Bundler Task
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

# RSpec Task
require 'rspec/core'
require 'rspec/core/rake_task'
desc 'Running RSpec Tests'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['test/**/*_spec.rb']
end
task :default => :spec

# Coveralls Task
require 'coveralls/rake/task'
desc 'Running Coveralls'
Coveralls::RakeTask.new
task :test_with_coveralls => [:spec, 'coveralls:push']

# Yard Task
require 'yard'
desc 'Run yarddoc for the source'
YARD::Rake::YardocTask.new do |t|
  t.files = %w('lib/**/*.rb', 'bin/PublicanCreators.rb', 'bin/RevisionCreator.rb', 'bin/setup.sh', '-', 'CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.rdoc')
end

# Setup procedure
desc 'Check target Linux System'
task :check_distro do
  puts 'Checking my host linux distribution'
  getdistro = `lsb_release -is`
  getdistver = `lsb_release -rs | cut -c1-2`
  distro = p getdistro.chomp
  distver = p getdistver.chomp
  if File.exist?('/etc/fedora-release') || File.exist?('/etc/redhat-release')
    puts 'Found Fedora/Redhat'
    puts 'Installing publican'
    system('sudo yum install publican*')
    @distcheck = 'fedora'
  else
    #puts 'Fedora/Redhat not found'
    @distcheck = ''
  end
  if File.exist?('/etc/SuSE-release')
    puts 'Found openSUSE'
    puts 'Can\'t prepare publican for openSUSE because there are no packages.'
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'
    @distcheck = 'opensuse'
  else
    #puts 'openSUSE not found'
    @distcheck = ''
  end
  if distro == 'Debian'
    puts 'Found Debian'
    puts 'Can\'t prepare publican for Debian. Maybe im preparing a setup routine later.'
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'
    @distcheck = 'debian'
  else
    #puts 'Debian not found'
    @distcheck = ''
  end
  if distro == 'Ubuntu'
    puts 'Found Ubuntu'
    if distver <= '13'
      puts 'You need a Ubuntu 14.04 version or newer to use PublicanCreators'
      @distcheck = ''
    else
      puts 'Your Ubuntu version is supported by Ubuntu'
      system('sudo apt-get install publican yad')
      system('sudo add-apt-repository ppa:sascha-manns-h/publican -y')
      system('sudo apt-get update')
      system('sudo apt-get install --only-upgrade publican')
      @distcheck = 'ubuntu'
    end
  else
    #puts 'Ubuntu not found'
    @distcheck = ''
  end
  if @distcheck == ''
    puts 'Sorry it looks like your OS isn\'t supported yet'
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'
  end
end

require 'fileutils'
desc 'Install Config file'
task :check_config do
  puts 'Checking Config file'
  home = Dir.home
  configorig = File.expand_path(File.join(File.dirname(__FILE__), 'lib/PublicanCreators', '.publicancreators.cfg'))
  if File.exist?("#{home}/.publicancreators.cfg")
    FileUtils.cp("#{configorig}", "#{home}/.publicancreators.cfg.new")
    puts "The newest config file was placed in #{home}/.publicancreators.cfg.new"
    puts "Please check if new parameters are shipped. If any are missed in your old config please add them into your file. Then remove #{home}/.publicancretors.cfg.new"
  else
    FileUtils.cp("#{configorig}", "#{home}/.publicancreators.cfg")
    puts "Config file not found. Copying the newest for you to #{home}/.publicancreators.cfg"
    if File.exist?('/usr/bin/gedit')
      editor = 'gedit'
    elsif File.exist?('/usr/bin/kate')
      editor = 'kate'
    elsif File.exist?('/usr/bin/moudepad')
      editor = 'mousepad'
    elsif File.exist?('/usr/bin/geany')
      editor = 'geany'
    elsif File.exist?('/usr/bin/jedit')
      editor = 'jedit'
    end
    system("#{editor} #{home}/.publicancreators.cfg")
  end
end

desc 'Link binary PublicanCreator.rb'
task :link_binary_cre do
  puts 'Linking binaries'
  publicancre = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'PublicanCreators.rb'))
  publicancrebin = '/usr/bin/publicancreators'
  if File.exist?("#{publicancrebin}")
    puts "File #{publicancrebin} exists. Removing it."
    system("sudo rm #{publicancrebin}")
    puts 'Removed'
  else
    puts "File #{publicancrebin} doesnt exist. Creating it"
    system("sudo ln -s #{publicancre} #{publicancrebin}")
    puts "Linked to #{publicancrebin}"
  end
end

desc 'Link binary RevisionCreator.rb'
task :link_binary_rev do
  publicanrev = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'RevisionCreator.rb'))
  publicanrevbin = '/usr/bin/publicancreators-rev'
  if File.exist?('#{publicanrevbin}')
    puts "File #{publicanrevbin} exists. Removing it"
    system("sudo rm #{publicanrevbin}")
    puts 'Removed'
  else
    puts "File #{publicanrevbin} doesnt exist. Creating it."
    system("sudo ln -s #{publicanrev} #{publicanrevbin}")
    puts "Linked to #{publicanrevbin}"
  end
end

require 'etc'
require 'fileutils'
desc 'Create Desktop files'
task :create_desktop_cre do
  home = Dir.home
  publicancre = "#{home}/.local/share/applications/publicancreators.desktop"
  publicancreico = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'publican.png'))
  if File.exist?(publicancre)
    puts 'Found old publicancreators.desktop file. Renew it now'
    uid = File.stat(publicancre).uid
    owner = Etc.getpwuid(uid).name
    if owner == 'root'
      system("sudo rm #{publicancre}")
    else
      FileUtils.rm(publicancre)
    end
  else
    FileUtils.touch "#{publicancre}"
    File.write "#{publicancre}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=/usr/bin/publicancreators
Icon=#{publicancreico}
EOF
  end
end

require 'etc'
require 'fileutils'
desc 'Create publicancreators-rev.desktop'
task :create_desktop_rev do
  home = Dir.home
  publicanrev = "#{home}/.local/share/applications/publicancreators-rev.desktop'"
  publicanrevico = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'publican-revision.png'))
  if File.exist?(publicanrev)
    puts 'Found old publicancreators-rev.desktop. Renew it now.'
    uid = File.stat(publicanrev).uid
    owner = Etc.getpwuid(uid).name
    if owner == 'root'
      system("sudo rm #{publicanrev}")
    else
      FileUtils.rm(publicanrev)
    end
  else
    FileUtils.touch "#{publicanrev}"
    File.write "#{publicanrev}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=/usr/bin/publicancreators-rev
Icon=#{publicanrevico}
EOF
  end
end

desc 'Run setup'
task :setup => [:check_distro, :check_config, :link_binary_cre, :link_binary_rev, :create_desktop_cre, :create_desktop_rev] do
  puts 'Finished Setup'
end

require 'fileutils'
desc 'Publish Userdocs'
task :publish_doc do
  version = PublicanCreatorsVersion::Version::STRING
  home = Dir.home
  srcde = 'docs/tmp/de-DE/html'
  srcen = 'docs/tmp/en-US/html'
  target = "#{home}/RubymineProjects/saigkill.github.com"
  targetde = "#{home}/RubymineProjects/saigkill.github.com/publicancreators/de-DE/html"
  targeten = "#{home}/RubymineProjects/saigkill.github.com/publicancreators/en-US/html"
  Checker.check_dir(targetde)
  Checker.check_dir(targeten)
  FileUtils.cp_r("#{srcde}/.", "#{targetde}")
  FileUtils.cp_r("#{srcen}/.", "#{targeten}")

  FileUtils.cd(target) do
    puts 'Adding missing files'
    system('git add *')
    puts 'Made commit'
    system("git commit -m \"Updated docs for PublicanCreators #{version}\"")
    puts 'Pushing it to origin'
    system('git push')
  end
end

# vim: syntax=ruby
