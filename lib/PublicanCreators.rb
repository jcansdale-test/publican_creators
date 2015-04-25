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
require 'fileutils'
require 'nokogiri'
require 'bundler/setup'

# Main class from PublicanCreators
class PublicanCreators
  my_name = 'PublicanCreators.rb'
  version = PublicanCreatorsVersion::VERSION

  puts "Script: #{my_name}"
  puts "Version: #{version}"
  puts
  puts 'Copyright (C) 2015 Sascha Manns <Sascha.Manns@xcom.de>'
  puts 'Description: This script creates a article or book set with'
  puts 'Publican. Then it modifies it for our needs.'
  puts 'License: GPL-3'
  puts ''
  puts 'This program is free software: you can redistribute it and/or modify'
  puts 'it under the terms of the GNU General Public License as published by'
  puts 'the Free Software Foundation, either version 3 of the License, or'
  puts '(at your option) any later version.'
  puts ''
  puts 'This program is distributed in the hope that it will be useful,'
  puts 'but WITHOUT ANY WARRANTY; without even the implied warranty of'
  puts 'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'
  puts 'GNU General Public License for more details.'
  puts 'You should have received a copy of the GNU General Public License'
  puts 'along with this program.  If not, see <http://www.gnu.org/licenses/>.'
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
  a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u = PublicanCreatorsGet.config
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

  home = Dir.home
  if environment == 'Work'
    if report == 'TRUE'
      articles_dir = "#{home}/#{reports_dir_business}"
    else
      articles_dir = "#{home}/#{articles_dir_business}"
    end
    books_dir = "#{home}/#{books_dir_business}"
  else
    if homework == 'FALSE'
      articles_dir = "#{home}/#{articles_dir_private}"
    else
      articles_dir = "#{home}/#{homework_dir_private}"
    end
    books_dir = "#{home}/#{books_dir_private}"
  end

  artinfo = "#{title}/de-DE/Article_Info.xml"
  bookinfo = "#{title}/de-DE/Book_Info.xml"
  revhist = "#{title}/de-DE/Revision_History.xml"
  agroup = "#{title}/de-DE/Author_Group.xml"
  builds = "#{title}/de-DE/build.sh"
  ent = "#{title}/de-DE/#{title}.ent"

  if type == 'Article'
    todo = "#{articles_dir}"
  else
    todo = "#{books_dir}"
  end

  puts "Creating directory #{todo}"
  # Checks if the needed directory is available. Otherwise it creates one.
  Checker.check_dir(todo)

  puts 'Change to this directory'
  # Change to target directory
  FileUtils.cd(todo) do

    if environment == 'Work'
      # Create the initial documentation for work
      PublicanCreatorsChange.init_docu_work(title, type, language, brand, db5)
    else
      if homework == 'TRUE'
        # Create the initial documentation for homework
        PublicanCreatorsChange.init_docu_homework(homework, type, language, title, brand_homework, db5)
      else
        # Create the initial documentation for private
        PublicanCreatorsChange.init_docu_private(title, type, language, brand_private, db5)
      end
    end

    # Add the entities to the entity file
    PublicanCreatorsChange.add_entity(ent, environment, global_entities, brand)

    # Change the default holder to the present one
    PublicanCreatorsChange.change_holder(title, ent, environment, name, company_name)

    # Remove legalnotice from Article_Info
    PublicanCreatorsChange.remove_legal(artinfo, environment, type, legal)

    if type == 'Article'
      # Remove title logo
      PublicanCreatorsChange.remove_orgname(artinfo, environment, title_logo)
    else
      # Remove title logo
      PublicanCreatorsChange.remove_orgname(bookinfo, environment, title_logo)
    end

    # Change the Revision History
    PublicanCreatorsChange.fix_revhist(revhist, environment, name, email_business, email)

    # Change Author group
    PublicanCreatorsChange.fix_authorgroup(agroup, environment, name, email, email_business, company_name, company_division)

    # Export a buildscript
    PublicanCreatorsExport.export_buildscript(title, builds, language)

    # Make buildscript executable
    PublicanCreatorsChange.make_buildscript_exe(builds)

    puts "Now you can find your documentation there: #{todo}/#{title}"

    puts "Thanks for using: #{my_name} #{version}"
  end
end
