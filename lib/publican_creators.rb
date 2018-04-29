#!/usr/bin/env ruby
# Copyright (C) 2013-2017 Sascha Manns <Sascha.Manns@mailbox.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Dependencies
require_relative 'publican_creators/checker'
require_relative 'publican_creators/get'
require_relative 'publican_creators/change'
require_relative 'publican_creators/export'
require_relative 'publican_creators/prepare'
require_relative 'publican_creators/notifier'
require 'fileutils'
require 'nokogiri'
require 'rainbow/ext/string'
require 'xdg'

# Main Class of PublicanCreators
# @return [String] true or false
class PublicanCreators
  # Versionizing
  VERSION = '1.2.0'.freeze

  puts 'publican_creators'.color(:yellow)
  puts "Version: #{VERSION}".color(:yellow)
  puts
  puts 'Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>'.color(:yellow)
  puts 'Description: This script creates a article or book set with'.color(:yellow)
  puts 'Publican. Then it modifies it for your needs.'.color(:yellow)
  puts 'License: GPL-3'.color(:yellow)
  puts 'Bugs: Please file bugs on https://bugs.launchpad.net/publicancreators'.color(:yellow)

  puts 'Reading the config file in publicancreators.cfg'.color(:yellow)
  # @note Run config method who reads in the config file and puts the variables in an array
  # TODO: Try to fix this in future (conf_ver, use_brand)
  # rubocop:disable Lint/UselessAssignment
  sys_xdg = XDG['CONFIG_HOME']
  config = ParseConfig.new("#{sys_xdg}/publican_creators/publicancreators.cfg")
  conf_ver = config['conf_ver']
  name = config['name']
  email = config['email_private']
  language = config['language']
  use_brand = config['use_brand']
  title_logo = config['title_logo']
  legal = config['legal']
  brand = config['brand']
  company_name = config['company_name']
  company_division = config['company_division']
  email_business = config['email_business']
  brand_dir = config['brand_dir']
  glob_entities = config['globalentities']
  articles_dir_business = config['articles_dir']
  reports_dir_business = config['reports_dir']
  books_dir_business = config['books_dir']
  articles_dir_private = config['articles_dir_priv']
  homework_dir_private = config['homework_dir']
  books_dir_private = config['books_dir_priv']
  brand_private = config['brand_private']
  brand_homework = config['brand_homework']
  db5 = config['db5']
  xfc_brand_dir = config['xfc_brand_dir']
  pdf_view = config['pdfview']

  global_entities = "#{brand_dir}/#{glob_entities}"
  puts "Your global entities file is there: #{global_entities}"

  # @note Ask for the title and other settings and put them into a array
  environment, type, opt, title = PublicanCreatorsGet.title

  puts "Environment: #{environment}"
  puts "Type: #{type}"
  puts "Optional: #{opt}"
  puts "Title: #{title}"

  # @note Sets the default values
  report = 'FALSE'
  homework = 'FALSE'
  report = 'TRUE' if opt == 'Report'
  homework = 'TRUE' if opt == 'Homework'

  # @note Hardcoded variables
  art_info = "#{title}/#{language}/Article_Info.xml"
  book_info = "#{title}/#{language}/Book_Info.xml"
  rev_hist = "#{title}/#{language}/Revision_History.xml"
  a_group = "#{title}/#{language}/Author_Group.xml"
  ent = "#{title}/#{language}/#{title}.ent"
  builds = "#{title}/#{language}/Rakefile"

  # Run one of the both methods to get the variable targetdir
  # @param [String] environment Comes from PublicanCreatorsGet.title
  # @param [String] type Comes from PublicanCreatorsGet.title
  # @param [String] report true or false
  # @param [String] reports_dir_business comes from publicancreators.cfg
  # @param [String] articles_dir_business comes from publicancreators.cfg
  # @param [String] books_dir_business comes from publicancreators.cfg
  # @param [String] articles_dir_private comes from publicancreators.cfg
  # @param [String] homework true or false
  # @param [String] homework_dir_private comes from publicancreators.cfg
  # @param [String] books_dir_private comes from publicancreators.cfg
  targetdir = PublicanCreatorsPrepare.targetdir(environment, type, report,
                                                reports_dir_business,
                                                articles_dir_business,
                                                books_dir_business, homework,
                                                articles_dir_private,
                                                homework_dir_private,
                                                books_dir_private)

  # Checks if the needed directory targetdir is available. Otherwise it creates one.
  puts "Creating directory #{targetdir}"
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or .prepare_private
  Checker.check_dir(targetdir)

  # @note Change to target directory
  puts 'Change to this directory'
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or .prepare_private
  FileUtils.cd(targetdir) do
    # This method checks the environment and runs the method for
    # @param [String] environment Comes from PublicanCreatorsGet.title
    # @param [String] title Comes from PublicanCreatorsGet.title
    # @param [String] type Comes from PublicanCreatorsGet.title
    # @param [String] language Comes from publicancreators.cfg
    # @param [String] brand e.g. Debian or nothing for using publicans default brand (config file)
    # @param [String] db5 DocBook5 as default? (config file)
    # @param [String] homework true or false
    # @param [String] brand_homework e.g. ils (config file)
    # @param [String] brand_private e.g. manns (config file)
    PublicanCreatorsChange.check_environment(environment, title, type, language,
                                             brand, db5, homework,
                                             brand_homework, brand_private)

    # By working for my employer i'm creating publications which refers to a global entity file.
    # This method adds the entities from that file into the local one. It returns a success or fail.
    # @param [String] environment Work or Private
    # @param [String] global_entities path to a global entities file (config file)
    # @param [String] ent Path to Entityfile
    PublicanCreatorsChange.add_entity(environment, global_entities, ent)

    # In this method the standard-holder from the local entity-file will be replaced with the company_name or if it
    # is a private work the name of the present user. It returns a sucess or fail.
    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] company_name (config file)
    # @param [String] ent Path to Entityfile
    PublicanCreatorsChange.change_holder(title, environment, name, company_name,
                                         ent)

    # This method removes the XI-Includes for the legal notice. It returns a sucess or fail.
    # @param [String] environment Work or Private
    # @param [String] type Book or Article
    # @param [String] legal remove legalnotice from article? (config file)
    # @param [String] art_info Path to Article_Info.xml
    PublicanCreatorsChange.remove_legal(environment, type, legal, art_info)

    # Checks if bookinfo or artinfo is needed, then it starts remove_orgname
    # @param [String] art_info path to Article_Info (hardcoded)
    # @param [String] book_info path to Book_Info (hardcoded)
    # @param [String] title_logo remove titlelogo from articlepage (config file)
    # @param [String] type Book or Article
    PublicanCreatorsChange.remove_orgname_prepare(book_info, art_info, title_logo,
                                                  type)

    # This method splits the name variable into firstname and surname. These variables are setted into the
    # Revision_History. If the environment is "Work" your email_business will be used, otherwise your private
    # email_address. It returns a sucess or fail.
    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] email private email address (config file)
    # @param [String] rev_hist Path to Revision_History.xml
    PublicanCreatorsChange.fix_revhist(environment, name, email_business, email,
                                       rev_hist)

    # This method replaces the standard values from Author_Group to the present user issues. It will be launched for
    # the Work environment. It returns a sucess or fail.
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] company_name your company's name (config file)
    # @param [String] company_division your companiy's division
    # @param [String] email your private email address
    # @param [String] environment Work or Private
    # @param [String] a_group Path to Author_Group.xml
    PublicanCreatorsChange.fix_authorgroup(name, email_business, company_name,
                                           company_division, email, environment,
                                           a_group)

    # Exports a predefined Shellscript to the target directory. It returns a sucess or fail.
    # @param [String] title comes from PublicanCreatorsGet.title
    # @param [String] builds path to buildscript (hardcoded)
    # @param [String] language comes from config file in format de-DE
    # @param [String] xfc_brand_dir if present the path to your branded xfc stylesheets (config file)
    # @param [String] pdf_view your prefered PDF-Viewer (config file)
    PublicanCreatorsExport.export_buildscript(title, builds, language,
                                              xfc_brand_dir, pdf_view)

    puts "Now you can find your documentation there: #{targetdir}/#{title}".color(:green)
    Notifier.run
    puts "Thanks for using: publican_creators #{VERSION}".color(:green)
  end
end
