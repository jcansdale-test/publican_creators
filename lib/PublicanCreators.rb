#!/usr/bin/env ruby
# PublicanCreators for Ruby
#
# Copyright (C) 2015  Sascha Manns <Sascha.Manns@xcom.de>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:#
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Dependencies
require 'PublicanCreators/version'
require 'PublicanCreators/checker'
require 'PublicanCreators/get'
require 'PublicanCreators/change'
require 'PublicanCreators/export'
require 'PublicanCreators/prepare'
require 'fileutils'
require 'nokogiri'
require 'bundler/setup'

# Main Class of PublicanCreators
# @return [bool] true or false
class PublicanCreators
  my_name = File.basename($0)
  version = PublicanCreatorsVersion::Version::STRING

  puts "Script: #{my_name}"
  puts "Version: #{version}"
  puts
  puts 'Copyright (C) 2015 Sascha Manns <Sascha.Manns@xcom.de>'
  puts 'Description: This script creates a article or book set with'
  puts 'Publican. Then it modifies it for your needs.'
  puts 'License: MIT'
  puts 'Bugs: Please file bugs on http://saigkill.ddns.net:8112/dashboard'
  puts ''
  puts 'Permission is hereby granted, free of charge, to any person obtaining a copy'
  puts 'of this software and associated documentation files (the "Software"), to deal'
  puts 'in the Software without restriction, including without limitation the rights'
  puts 'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'
  puts 'copies of the Software, and to permit persons to whom the Software is'
  puts 'furnished to do so, subject to the following conditions:'
  puts ''
  puts 'The above copyright notice and this permission notice shall be included in'
  puts 'all copies or substantial portions of the Software.'
  puts ''
  puts 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'
  puts 'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'
  puts 'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'
  puts 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'
  puts 'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'
  puts 'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN'
  puts 'THE SOFTWARE.'

  home = Dir.home
  if File.exist?("#{home}/.publicancreators.cfg")
    puts 'Found configuration file and using it...'
  else
    puts 'Please run bin/setup.sh'
    raise('Exiting now..')
  end

  puts 'Reading the config file in ~/.publicancreators.cfg'
  # Run config method who reads in the config file and puts the variables in an array
  PublicanCreatorsGet.config
  a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v = PublicanCreatorsGet.config
  name = "#{a}"
  email = "#{b}"
  language = "#{c}"
  use_brand = "#{d}"
  title_logo = "#{e}"
  legal = "#{f}"
  brand = "#{g}"
  company_name = "#{h}"
  company_division = "#{i}"
  email_business = "#{j}"
  brand_dir = "#{k}"
  glob_entities = "#{l}"
  articles_dir_business = "#{m}"
  reports_dir_business = "#{n}"
  books_dir_business = "#{o}"
  articles_dir_private = "#{p}"
  homework_dir_private = "#{q}"
  books_dir_private = "#{r}"
  brand_private = "#{s}"
  brand_homework = "#{t}"
  db5 = "#{u}"
  conf_ver = "#{v}"

  puts 'Your configuration is:'
  puts "Your Name: #{name}"
  puts "Your private emailaddress: #{email}"
  puts "Your choosen language: #{language}"
  puts "Using an own brand: #{use_brand}"
  puts "Leave title_logo: #{title_logo}"
  puts "Leave legalnotice in article: #{legal}"
  puts "Choosen brand: #{brand}"
  puts "Your company name: #{company_name}"
  puts "Your company division: #{company_division}"
  puts "Your business email address: #{email_business}"
  puts "Your brand dir: #{brand_dir}"
  puts "Your global entities: #{glob_entities}"
  puts "Your business articles dir: #{articles_dir_business}"
  puts "Your business reports dir: #{reports_dir_business}"
  puts "Your business books dir: #{books_dir_business}"
  puts "Your private articles dir: #{articles_dir_private}"
  puts "Your homework dir: #{homework_dir_private}"
  puts "Your private books dir: #{books_dir_private}"
  puts "Your private brand: #{brand_private}"
  puts "Your homework brand: #{brand_homework}"
  puts "DocBook5 as default: #{db5}"
  puts "Config version: #{conf_ver}"

  global_entities = "#{brand_dir}/#{glob_entities}"

  # Ask for the title and other settings via yad and put them into a array
  titleget = PublicanCreatorsGet.title
  environment = titleget[0] # Work or Private
  type = titleget[1] # Article or Book
  opt = titleget[2] # Report or homework
  title = titleget[3] # title

  puts "Environment: #{environment}"
  puts "Type: #{type}"
  puts "Optional: #{opt}"
  puts "Title: #{title}"

  # Set default values
  if opt == 'Report'
    report = 'TRUE'
  else
    report = 'FALSE'
  end
  if opt == 'Homework'
    homework = 'TRUE'
  else
    homework = 'FALSE'
  end

  # Hardcoded variables
  artinfo = "#{title}/de-DE/Article_Info.xml"
  bookinfo = "#{title}/de-DE/Book_Info.xml"
  builds = "#{title}/de-DE/build.sh"

  # Run one of the both methods to get the variable todo
  if environment == 'Work'
    todo = PublicanCreatorsPrepare.prepare_work(type, reports_dir_business, articles_dir_business, report, books_dir_business)
  else
    todo = PublicanCreatorsPrepare.prepare_private(type, homework, articles_dir_private, homework_dir_private, books_dir_private)
  end

  # Checks if the needed directory todo is available. Otherwise it creates one.
  puts "Creating directory #{todo}"
  Checker.check_dir(todo)

  # Change to target directory
  puts 'Change to this directory'
  FileUtils.cd(todo) do

    if environment == 'Work'
      PublicanCreatorsChange.init_docu_work(title, type, language, brand, db5)
    else
      PublicanCreatorsChange.init_docu_private(title, type, homework, language, brand_homework, brand_private, db5)
    end

    PublicanCreatorsChange.add_entity(title, environment, global_entities, brand)

    PublicanCreatorsChange.change_holder(title, environment, name, company_name)

    PublicanCreatorsChange.remove_legal(title, environment, type, legal) #

    if type == 'Article'
      PublicanCreatorsChange.remove_orgname(artinfo, environment, title_logo, type) #
    else
      PublicanCreatorsChange.remove_orgname(bookinfo, environment, title_logo, type) #
    end

    PublicanCreatorsChange.fix_revhist(environment, name, email_business, email, title)

    if environment == 'Work'
      PublicanCreatorsChange.fix_authorgroup_work(title, name, email_business, company_name, company_division)
    else
      PublicanCreatorsChange.fix_authorgroup_private(name, email, title)
    end

    PublicanCreatorsExport.export_buildscript(title, builds, language)

    PublicanCreatorsChange.make_buildscript_exe(builds)

    puts "Now you can find your documentation there: #{todo}/#{title}"

    puts "Thanks for using: #{my_name} #{version}"
  end
end
