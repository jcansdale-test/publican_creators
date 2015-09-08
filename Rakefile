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
# rubocop:disable Metrics/LineLength
YARD::Rake::YardocTask.new do |t|
  t.files = %w('lib/**/*.rb', 'bin/publican_creators.rb',
'bin/revision_creator.rb',  '-', 'CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.md', 'README.md')
end

# Rubocop
require 'rubocop/rake_task'
desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb, test/**/*.rb']
  # only show the files with failures
  task.formatters = ['files']
  # don't abort rake on failure
  task.fail_on_error = false
end

# Reek
require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.name = 'reek'
  t.config_file = 'config.reek'
  t.source_files = 'lib/**/*.rb'
  t.reek_opts = '' # -U
  t.fail_on_error = false
  t.verbose = true
end

# Setup procedure
desc 'Launching the setup'
task :setup_start do
  version = PublicanCreators::Version::STRING
  puts '######################################################'.color(:yellow)
  puts '#            PublicanCrators Setup                   #'.color(:yellow)
  puts "#            Version: #{version}                         #".color(:yellow)
  puts '#                                                    #'.color(:yellow)
  puts '# Please file bugreports on:                         #'.color(:yellow)
  puts '# http://saigkill-bugs.myjetbrains.com/youtrack      #'.color(:yellow)
  puts '######################################################'.color(:yellow)
end

desc 'Link binary PublicanCreator.rb'
task :link_binary_cre do
  puts 'Removing binaries'
  publicancrebin = '/usr/bin/publicancreators'
  system("sudo rm #{publicancrebin}") if File.exist?("#{publicancrebin}")
end

desc 'Link binary revision_creator.rb'
task :link_binary_rev do
  publicanrevbin = '/usr/bin/publicancreators-rev'
  system("sudo rm #{publicanrevbin}") if File.exist?("#{publicanrevbin}")
end

require 'etc'
require 'fileutils'
desc 'Create Desktop files'
task :create_desktop_cre do
  home = Dir.home
  prefix = "#{home}/.rvm/rubies/default"
  datadir = "#{prefix}/share"
  publicancre = "#{home}/.local/share/applications/publicancreators.desktop"
  publicancreico = "#{datadir}/.publican_creators/publican.png"
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
  publicanrevico = "#{datadir}/.publican_creators/publican-revision.png"
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

desc 'Setup'
task :setuprb do
  system('setup uninstall --force')
  system('setup.rb config --sysconfdir=$HOME/.publican_creators')
  system('setup.rb install')
end

desc 'Run setup'
task :setup => [:setup_start, :link_binary_cre, :link_binary_rev, :create_desktop_cre, :create_desktop_rev, :backup_config, :setuprb] do
  puts 'Finished Setup'.color(:green)
end

require 'fileutils'
desc 'Prepare Userdocs for translating'
task :prepare_doc do
  docs = './doc'
  FileUtils.cd(docs) do
    puts 'Running trans_drop'.color(:yellow)
    system('publican trans_drop')
    puts 'Preparing pot files'.color(:yellow)
    system('publican update_pot')
    puts 'Preparing po files for de-DE'.color(:yellow)
    system('publican update_po --langs=de-DE')
    puts 'All done. Please use a poeditor (like poedit) to translate'.color(:green)
    puts 'For building doc use rake build_doc.'.color(:green)
  end
end

require 'fileutils'
desc 'Build Userdocs'
task :build_doc do
  docs = './doc'
  FileUtils.cd(docs) do
    puts 'Building all targets'.color(:yellow)
    system('publican build --langs=en-US,de-DE --formats=html,pdf')
    puts 'All done. Please use rake publish_doc for publishing.'.color(:green)
  end
end

require 'fileutils'
desc 'Publish Userdocs'
task :publish_doc do
  version = PublicanCreators::Version::STRING
  home = Dir.home
  srcde = 'doc/tmp/de-DE/html'
  srcen = 'doc/tmp/en-US/html'
  srcdepdf = 'doc/tmp/de-DE/pdf'
  srcenpdf = 'doc/tmp/en-US/pdf'
  target = "#{home}/RubymineProjects/saigkill.github.com"
  targetde = "#{home}/RubymineProjects/saigkill.github.com/doc/publicancreators/de-DE/html"
  targeten = "#{home}/RubymineProjects/saigkill.github.com/doc/publicancreators/en-US/html"
  targetenpdf = "#{home}/RubymineProjects/saigkill.github.com/doc/publicancreators/en-US/pdf"
  targetdepdf = "#{home}/RubymineProjects/saigkill.github.com/doc/publicancreators/de-DE/pdf"

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
    system("git commit -m \"Updated doc for PublicanCreators #{version}\"")
    puts 'Pushing it to origin'.color(:green)
    system('git push')
  end
end

require 'MannsShared'
require 'yaml'
require 'fileutils'
desc 'Prepares for release'
task :make_release do
  version = PublicanCreators::Version::STRING
  home = Dir.home
  target = "#{home}/RubymineProjects/saigkill.github.com/_posts"
  time = Time.new
  date = time.strftime('%Y-%m-%d')
  config = YAML.load_file('Index.yml')
  oldversion = config['version']

  puts('Updating index')
  MannsShared.search_replace(oldversion, version, 'Index.yml')
  MannsShared.search_replace(oldversion, version, 'VERSION')
  system('index --using VERSION Index.yml')
  puts 'Updating MANIFEST'
  system('mast -u && mast -u')
  system('git add MANIFEST')
  puts 'done'
  puts 'Updating workspace'
  system('git add .idea/*')
  system('git commit -m "Updated workspace"')
  puts 'done'
  puts 'Making release'
  system('rake release')

  FileUtils.cd(target) do
    FileUtils.touch "#{date}-PublicanCreators-#{version}-released-en.md"
    File.write "#{date}-PublicanCreators-#{version}-released-en.md", <<EOF
---
layout: post
title: "PublicanCreators #{version} - A Gem for DocBook Publishers"
description: "Using DocBook and Redhat's Publican daily? Then this Rubygem made your day."
category: "programming"
tags: [ruby, opensource, publican, en-US]
---
{% include JB/setup %}

# Introduction
PublicanCreators are a small tool for daily DocBook writers who are using the Redhat publican tool [fedorahosted.org/publican/]. PublicanCreators asks after launching which title, type and environment should be used. Then it starts publican with that settings and works then with the produced files. It will work inside the Article_Info.xml, Book_Info.xml, TITLE.ent, Author_Group.xml and Revision_History.xml and will replace the default values with your name, your company, your company_divison and your private or your business email address, depending on your chosen environment. Also you can set inside your config file that you want to remove the Title Logo or the Legal Notice. As a feature it ships a build script for each project.

# Installation
If you give it a try just follow the next steps (If you have already Ruby installed):

  * gem install PublicanCreators
  * cd /path/to/gem
  * rake setup

# Dependencies
You need to have yad and publican (a 4.x version) installed. If you use Ubuntu you can use the ppa ppa:sascha-manns-h/publican

# Running the Gem
To run it you can type publican_creators.rb, or just use the launcher.

# Downloads
All downloads of PublicanCreators:
[![downloads-all](https://img.shields.io/gem/dt/PublicanCreators.svg)](https://rubygems.org/gems/PublicanCreators)
# References
  * Projects home: [https://github.com/saigkill/PublicanCreators](https://github.com/saigkill/PublicanCreators)
  * User documentation (en): [http://saigkill.github.io/doc/publicancreators/en-US/html](http://saigkill.github.io/doc/publicancreators/en-US/html)
  * User documentation (de): [http://saigkill.github.io/doc/publicancreators/de-DE/html](http://saigkill.github.io/doc/publicancreators/de-DE/html)
  * Bug reports: [http://saigkill.ddns.net:8112/dashboard](http://saigkill.ddns.net:8112/dashboard)

# What has be done in this version #{version}?
  * Step 1
  * Step2

# Donations
[![publicancreators](https://pledgie.com/campaigns/29306.png?skin_name=chrome)](https://pledgie.com/campaigns/29306)
EOF
  end
  FileUtils.cd(target) do
    FileUtils.touch "#{date}-PublicanCreators-#{version}-released-de.md"
    File.write "#{date}-PublicanCreators-#{version}-released-de.md", <<EOF
---
layout: post
title: "PublicanCreators #{version} - Ein Gem für DocBook Publishers"
description: "Benutzen Sie täglich DocBook und Redhat's publican? Dann ist dieses Gem für Sie."
category: "programming"
tags: [ruby, opensource, publican, de-DE]
---
{% include JB/setup %}

# Einleitung
PublicanCreators ein kleines Tool für tägliche DocBook-Schreiber, die das Publican Tool [fedorahosted.org/publican/] nutzen.
Nach dem Start fragt PublicanCreators nach dem Titel des Projektes, dem Projekttyp und die aktuelle Umgebung. Dies nutzt PublicanCreators um die von publican erzeugten Dateien zu manipulieren. So bearbeitet es die Article_Info.xml, Book_Info.xml, TITLE.ent, Author_Group.xml und die Revision_History. Es setzt Ihren Namen, den Ihrer Firma, den Ihrer Abteilung oder auch die private oder geschäftliche Emailadresse (je nach benutzter Umgebung). Im Configfile des Programms können weitere Einstellungen vorgenommen werden, wie das entfernen des Titel Logos oder der Legal Notice. Abschließend generiert das Programm ein Buildscript (Rakefile) für jedes Projekt.

# Installation
Wenn Ruby bereits installiert ist, kann PublicanCreators wie folgt installiert werden:

  * gem install PublicanCreators
  * cd /path/to/gem
  * rake setup

# Abhängigkeiten
Sie benötigen yad und publican (eine 4.x version), die bereits installiert sein müssen. Falls Sie Ubuntu nutzen, können Sie das ppa ppa:sascha-manns-h/publican nutzen.

# Das Gem starten
Starten Sie publican_creators.rb, oder benutzen Sie einfach den launcher.

# Downloads
Gesamtdownloads von PublicanCreators:
[![downloads-all](https://img.shields.io/gem/dt/PublicanCreators.svg)](https://rubygems.org/gems/PublicanCreators)
# Referenzen
  * Projekt Home: [https://github.com/saigkill/PublicanCreators](https://github.com/saigkill/PublicanCreators)
  * User Dokumentation (en): [http://saigkill.github.io/doc/publicancreators/en-US/html](http://saigkill.github.io/doc/publicancreators/en-US/html)
  * User Dokumentation (de): [http://saigkill.github.io/doc/publicancreators/de-DE/html](http://saigkill.github.io/doc/publicancreators/de-DE/html)
  * Bugreports: [http://saigkill.ddns.net:8112/dashboard](http://saigkill.ddns.net:8112/dashboard)

# Was ist neu in version #{version}?
  * Step 1
  * Step2

# Donations
[![publicancreators](https://pledgie.com/campaigns/29306.png?skin_name=chrome)](https://pledgie.com/campaigns/29306)
EOF
  end
  puts 'Prepared your Blogpost. Please add the changes of this release'
  puts 'Now ready for social media posting'

  # Create email to ruby-talk
  space = '%20'
  crlf = '%0D%0A'
  subject = "PublicanCreators #{version} released"
  subject.gsub!(/ /, "#{space}")
  body = 'Hello Ruby list,' + "#{crlf}" + "#{crlf}" +
      "i would like to announce the PublicanCreators gem in version #{version}." + "#{crlf}" + "#{crlf}" +
      "What happend in version #{version}?" + "#{crlf}" +
      '* Its the initial release' + "#{crlf}" +
      '* Fixed LCV 1-4' + "#{crlf}" + "#{crlf}" +
      'What is PublicanCreators?' + "#{crlf}" + "#{crlf}" +
      'PublicanCreators are a small tool for daily DocBook writers who are using the Redhat publican tool' + "#{crlf}" + "#{crlf}" +
      'Installation:'+ "#{crlf}" + "#{crlf}" +
      '    gem install PublicanCreators' + "#{crlf}" +
      '    cd /path/to/gem \(In case of using RVM anything like ~/.rvm/gems/ruby-2.2.1/gems/latex_curriculum_vitae\)' + "#{crlf}" +
      '    rake setup' + "#{crlf}" + "#{crlf}" +
      'Dependencies:'+ "#{crlf}" + "#{crlf}" +
      '* publican' + "#{crlf}" +
      '* yad' + "#{crlf}" + "#{crlf}" +
      'Using the gem:' + "#{crlf}" + "#{crlf}" +
      'To use the gem just type in the console:' + "#{crlf}" + "#{crlf}" +
      '    publican_creators.rb' + "#{crlf}" + "#{crlf}" +
      'or use the launcher.' + "#{crlf}" + "#{crlf}" +
      'References:' + "#{crlf}" +
      '* Issue tracker: http://saigkill-bugs.myjetbrains.com/youtrack/issues' + "#{crlf}" +
      '* Home: https://github.com/saigkill/PublicanCreators' + "#{crlf}" +
      'Greetings Sascha'
  body.gsub!(/ /, "#{space}")
  system("thunderbird mailto:ruby-talk@ruby-lang.org?subject=#{subject}\\&body=#{body}")
  system('rm pkg/*')
end
# vim: syntax=ruby
