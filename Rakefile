# -*- ruby -*-
require 'bundler/gem_tasks'
require 'rubygems'
require 'rainbow/ext/string'

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
  t.files = %w('lib/**/*.rb', 'bin/PublicanCreators.rb', 'bin/RevisionCreator.rb',  '-', 'CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.rdoc')
end

# Setup procedure
desc 'Launching the setup'
task :setup_start do
  version = PublicanCreatorsVersion::Version::STRING
  puts '######################################################'.color(:yellow)
  puts '#            PublicanCrators Setup                   #'.color(:yellow)
  puts "#            Version: #{version}                        #".color(:yellow)
  puts '#                                                    #'.color(:yellow)
  puts '# Please file bugreports on:                         #'.color(:yellow)
  puts '# http://saigkill.ddns.net:8112/dashboard            #'.color(:yellow)
  puts '######################################################'.color(:yellow)
end

desc 'Check target Linux System'
task :check_distro do
  puts 'Checking my host linux distribution'.color(:yellow)
  getdistro = `lsb_release -is`
  getdistver = `lsb_release -rs | cut -c1-2`
  distro = p getdistro.chomp
  distver = p getdistver.chomp
  if File.exist?('/etc/fedora-release') || File.exist?('/etc/redhat-release')
    puts 'Found Fedora/Redhat'.color(:yellow)
    puts 'Installing publican'.color(:yellow)
    system('sudo yum install publican*')
    @distcheck = 'fedora'
  else
    @distcheck = ''
  end
  if File.exist?('/etc/SuSE-release')
    puts 'Found openSUSE'.color(:yellow)
    puts 'Can\'t prepare publican for openSUSE because there are no packages.'.color(:red)
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'.color(:red)
    @distcheck = 'opensuse'
  else
    @distcheck = ''
  end
  if distro == 'Debian'
    puts 'Found Debian'.color(:yellow)
    puts 'Can\'t prepare publican for Debian. Maybe im preparing a setup routine later.'.color(:red)
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'.color(:red)
    @distcheck = 'debian'
  else
    @distcheck = ''
  end
  if distro == 'Ubuntu'
    puts 'Found Ubuntu'.color(:yellow)
    if distver <= '13'
      puts 'You need a Ubuntu 14.04 version or newer to use PublicanCreators'.color(:red)
      @distcheck = ''
    else
      puts 'Your Ubuntu version is supported by Ubuntu'.color(:yellow)
      system('sudo apt-get install publican yad')
      system('sudo add-apt-repository ppa:sascha-manns-h/publican -y')
      system('sudo apt-get update')
      system('sudo apt-get install --only-upgrade publican')
      @distcheck = 'ubuntu'
    end
  else
    @distcheck = ''
  end
  if @distcheck == ''
    puts 'Sorry it looks like your OS isn\'t supported yet'.color(:red)
    puts 'You can try to install publican with this Howto: http://bit.ly/1dQtGLa'.color(:red)
  end
end

require 'fileutils'
desc 'Install Config file'
task :check_config do
  puts 'Checking Config file'.color(:yellow)
  home = Dir.home
  configorig = File.expand_path(File.join(File.dirname(__FILE__), 'lib/PublicanCreators', '.publicancreators.cfg'))
  if File.exist?("#{home}/.publicancreators.cfg")
    FileUtils.cp("#{configorig}", "#{home}/.publicancreators.cfg.new")
    puts "The newest config file was placed in #{home}/.publicancreators.cfg.new".color(:yellow)
    puts "Please check if new parameters are shipped. If any are missed in your old config please add them into your file. Then remove #{home}/.publicancretors.cfg.new".color(:blue)
  else
    FileUtils.cp("#{configorig}", "#{home}/.publicancreators.cfg")
    puts "Config file not found. Copying the newest for you to #{home}/.publicancreators.cfg".color(:yellow)
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
    puts "File #{publicancrebin} exists. Removing it.".color(:yellow)
    system("sudo rm #{publicancrebin}")
    puts 'Removed'.color(:yellow)
  else
    puts "File #{publicancrebin} doesnt exist. Creating it".color(:yellow)
    system("sudo ln -s #{publicancre} #{publicancrebin}")
    puts "Linked to #{publicancrebin}".color(:yellow)
  end
end

desc 'Link binary RevisionCreator.rb'
task :link_binary_rev do
  publicanrev = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'RevisionCreator.rb'))
  publicanrevbin = '/usr/bin/publicancreators-rev'
  if File.exist?("#{publicanrevbin}")
    puts "File #{publicanrevbin} exists. Removing it".color(:yellow)
    system("sudo rm #{publicanrevbin}")
    puts 'Removed'.color(:yellow)
  else
    puts "File #{publicanrevbin} doesnt exist. Creating it.".color(:yellow)
    system("sudo ln -s #{publicanrev} #{publicanrevbin}")
    puts "Linked to #{publicanrevbin}".color(:yellow)
  end
end

require 'etc'
require 'fileutils'
desc 'Create Desktop files'
task :create_desktop_cre do
  home = Dir.home
  publicancre = "#{home}/.local/share/applications/publicancreators.desktop"
  publicancreico = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'publican.png'))
  publicancrebin = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'PublicanCreators.rb'))
  FileUtils.rm(publicancre)
  puts 'Creating Desktop file for PublicanCreators'.color(:yellow)
  FileUtils.touch "#{publicancre}"
  File.write "#{publicancre}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=#{publicancrebin}
Icon=#{publicancreico}
EOF
end

require 'etc'
require 'fileutils'
desc 'Create publicancreators-rev.desktop'
task :create_desktop_rev do
  home = Dir.home
  publicanrev = "#{home}/.local/share/applications/publicancreators-rev.desktop"
  publicanrevico = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'publican-revision.png'))
  publicanrevbin = File.expand_path(File.join(File.dirname(__FILE__), 'bin/', 'RevisionCreator.rb'))
  FileUtils.rm(publicanrev)
  puts 'Creating Desktop file for PublicanCreatorsRevision'.color(:yellow)
  FileUtils.touch "#{publicanrev}"
  File.write "#{publicanrev}", <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreatorsRevision
Exec=#{publicanrevbin}
Icon=#{publicanrevico}
EOF
end

desc 'Run setup'
task :setup => [:setup_start, :check_distro, :check_config, :link_binary_cre, :link_binary_rev, :create_desktop_cre, :create_desktop_rev] do
  puts 'Finished Setup'.color(:green)
end

require 'fileutils'
desc 'Prepare Userdocs for translating'
task :prepare_doc do
  docs = './docs'
  FileUtils.cd(docs) do
    puts 'Running trans_drop'.color(:yellow)
    system('publican trans_drop')
    puts 'Preparing pot files'.color(:yellow)
    system('publican update_pot')
    puts 'Preparing po files for de-DE'.color(:yellow)
    system('publican update_po --langs=de-DE')
    puts 'All done. Please use a poeditor (like poedit) to translate'.color(:green)
    puts 'For building docs use rake build_doc.'.color(:green)
  end
end

require 'fileutils'
desc 'Build Userdocs'
task :build_doc do
  docs = './docs'
  FileUtils.cd(docs) do
    puts 'Building all targets'.color(:yellow)
    system('publican build --langs=en-US,de-DE --formats=html,pdf')
    puts 'All done. Please use rake publish_doc for publishing.'.color(:green)
  end
end

require 'fileutils'
desc 'Publish Userdocs'
task :publish_doc do
  version = PublicanCreatorsVersion::Version::STRING
  home = Dir.home
  srcde = 'docs/tmp/de-DE/html'
  srcen = 'docs/tmp/en-US/html'
  srcdepdf = 'docs/tmp/de-DE/pdf'
  srcenpdf = 'docs/tmp/en-US/pdf'
  target = "#{home}/RubymineProjects/saigkill.github.com"
  targetde = "#{home}/RubymineProjects/saigkill.github.com/docs/publicancreators/de-DE/html"
  targeten = "#{home}/RubymineProjects/saigkill.github.com/docs/publicancreators/en-US/html"
  targetenpdf = "#{home}/RubymineProjects/saigkill.github.com/docs/publicancreators/en-US/pdf"
  targetdepdf = "#{home}/RubymineProjects/saigkill.github.com/docs/publicancreators/de-DE/pdf"

  puts 'Copying source html files to target git repository'.color(:yellow)
  FileUtils.cp_r(Dir["#{srcde}/*"], "#{targetde}")
  FileUtils.cp_r(Dir["#{srcen}/*"], "#{targeten}")
  FileUtils.cp_r(Dir["#{srcdepdf}/*"], "#{targetdepdf}")
  FileUtils.cp_r(Dir["#{srcenpdf}/*"], "#{targetenpdf}")

  puts 'Checking in into repository'.color(:yellow)
  FileUtils.cd(target) do
    puts 'Adding missing files'.color(:yellow)
    system('git add *')
    puts 'Made commit'.color(:yellow)
    system("git commit -m \"Updated docs for PublicanCreators #{version}\"")
    puts 'Pushing it to origin'.color(:green)
    system('git push')
  end
end

# vim: syntax=ruby
