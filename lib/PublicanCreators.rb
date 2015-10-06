#!/usr/bin/env ruby
# @author Sascha Manns
# @abstract Main Class for PublicanCreators
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'publican_creators/checker'
require 'publican_creators/get'
require 'publican_creators/change'
require 'publican_creators/export'
require 'publican_creators/prepare'
require 'publican_creators/notifier'
require 'fileutils'
require 'nokogiri'
require 'rainbow/ext/string'
require 'bundler/setup'
require 'manns_shared'

# Main Class of PublicanCreators
# @return [String] true or false
class PublicanCreators
  # Versionizing
  VERSION = '1.0.0'

  my_name = File.basename($PROGRAM_NAME)

  puts "Script: #{my_name}"
  puts "Version: #{version}"
  puts
  puts 'Copyright (C) 2015 Sascha Manns <samannsml@directbox.com>'
  puts 'Description: This script creates a article or book set with'
  puts 'Publican. Then it modifies it for your needs.'
  puts 'License: GPL-3'
  puts 'Bugs: Please file bugs on http://saigkill-bugs.myjetbrains.com/youtrack/'

  puts 'Reading the config file in publicancreators.cfg'
  # @note Run config method who reads in the config file and puts the variables
  # in an array
  # name, email, language, use_brand, title_logo, legal, brand, company_name,
  #     company_division, email_business, brand_dir, glob_entities,
  #     articles_dir_business, reports_dir_business, books_dir_business,
  #     articles_dir_private, homework_dir_private, books_dir_private,
  #     brand_private, brand_homework, db5, conf_ver, xfc_brand_dir,
  #     pdfview = PublicanCreatorsGet.config

  home = Dir.home
  config = ParseConfig.new("#{home}/.publican_creators/publicancreators.cfg")
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
  pdfview = config['pdfview']

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
  puts "XFC brand dir: #{xfc_brand_dir}"
  puts "Your prefered PDF-Viewer: #{pdfview}"

  global_entities = "#{brand_dir}/#{glob_entities}"
  puts "Your global entities file is there: #{global_entities}"

  # @note Ask for the title and other settings via yad and put them into a array
  environment, type, opt, title = PublicanCreatorsGet.title

  puts "Environment: #{environment}"
  puts "Type: #{type}"
  puts "Optional: #{opt}"
  puts "Title: #{title}"

  # This method sets the default value for report
  # @param [String] opt Can be Report or Homework or Normal
  # @return [String] report

  report = 'FALSE'
  homework = 'FALSE'
  report = 'TRUE' if opt == 'Report'
  homework = 'TRUE' if opt == 'Homework'

  # @note Hardcoded variables
  artinfo = "#{title}/#{language}/Article_Info.xml"
  bookinfo = "#{title}/#{language}/Book_Info.xml"
  revhist = "#{title}/#{language}/Revision_History.xml"
  agroup = "#{title}/#{language}/Author_Group.xml"
  ent = "#{title}/#{language}/#{title}.ent"
  builds = "#{title}/#{language}/Rakefile"

  # @note Run one of the both methods to get the variable targetdir
  # @param [String] type Book or Article
  # @param [String] reports_dir_business path to that dir where you store your
  #                 reports
  # @param [String] articles_dir_business path to that dir where you store
  #                 business articles
  # @param [String] report true or false
  # @param [String] books_dir_business path to that dir where you store your
  #                 business books
  # @param [String] true or false
  # @param [String] articles_dir_private path to your private articles directory
  # @param [String] homework path to your homework directory
  # @param [String] books_dir_private path to your private books directory
  targetdir = PublicanCreatorsPrepare.targetdir(environment, type, report,
                                                reports_dir_business,
                                                articles_dir_business,
                                                books_dir_business, homework,
                                                articles_dir_private,
                                                homework_dir_private,
                                                books_dir_private)

  # @note Checks if the needed directory targetdir is available. Otherwise it
  # creates one.
  puts "Creating directory #{targetdir}"
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or
  # .prepare_private
  MannsShared.check_dir(targetdir)

  # @note Change to target directory
  puts 'Change to this directory'
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or
  # .prepare_private
  FileUtils.cd(targetdir) do
    # @param [String] title comes from titleget[3]
    # @param [String] type Book or Article
    # @param [String] language comes from config file in format de-DE
    # @param [String] brand e.g. Debian or nothing for using publicans default
    #                 brand (config file)
    # @param [String] db5 DocBook5 as default? (config file)
    # @param [String] homework true or false
    # @param [String] brand_homework e.g. ils (config file)
    # @param [String] brand_private e.g. manns (config file)
    PublicanCreatorsChange.check_environment(environment, title, type, language,
                                             brand, db5, homework,
                                             brand_homework, brand_private)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] global_entities path to a global entities file
    #                 (config file)
    # @param [String] brand e.g. Debian or nothing for using publicans default
    #                 brand (config file)
    PublicanCreatorsChange.add_entity(environment, global_entities, ent)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] company_name (config file)
    PublicanCreatorsChange.change_holder(title, environment, name, company_name,
                                         ent)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] type Book or Article
    # @param [String] legal remove legalnotice from article? (config file)
    PublicanCreatorsChange.remove_legal(environment, type, legal, artinfo)

    # @param [String] artinfo path to Article_Info (hardcoded)
    # @param [String] bookinfo path to Book_Info (hardcoded)
    # @param [String] title_logo remove titlelogo from articlepage (config file)
    # @param [String] type Book or Article
    PublicanCreatorsChange.remove_orgname_prepare(bookinfo, artinfo, title_logo,
                                                  type)

    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] title comes from titleget[3]
    PublicanCreatorsChange.fix_revhist(environment, name, email_business, email,
                                       revhist)

    # @param [String] title comes from titleget[3]
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] company_name your company's name (config file)
    # @param [String] company_division your companiy's division
    # @param [String] email your private email address
    PublicanCreatorsChange.fix_authorgroup(name, email_business, company_name,
                                           company_division, email, environment,
                                           agroup)

    # @param [String] title comes from titleget[3]
    # @param [String] builds path to buildscript (hardcoded)
    # @param [String] language comes from config file in format de-DE
    # @param [String] xfc_brand_dir if present the path to your branded xfc
    #                 stylesheets (config file)
    # @param [String] pdfview your prefered PDF-Viewer (config file)
    PublicanCreatorsExport.export_buildscript(title, builds, language,
                                              xfc_brand_dir, pdfview)

    puts "Now you can find your documentation there: #{targetdir}/#{title}"
    Notifier.run
    puts "Thanks for using: #{my_name} #{version}"
  end
end
