#!/usr/bin/env ruby
# @author Sascha Manns
# @abstract Main Class for PublicanCreators
#
# Copyright (C) 2015  Sascha Manns <Sascha.Manns@bdvb.de>
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
require 'rainbow/ext/string'
require 'bundler/setup'

# Main Class of PublicanCreators
# @return [String] true or false
class PublicanCreators
  my_name = File.basename($0)
  version = PublicanCreatorsVersion::Version::STRING

  puts "Script: #{my_name}".color(:yellow)
  puts "Version: #{version}".color(:yellow)
  puts
  puts 'Copyright (C) 2015 Sascha Manns <Sascha.Manns@bdvb.de>'.color(:yellow)
  puts 'Description: This script creates a article or book set with'.color(:yellow)
  puts 'Publican. Then it modifies it for your needs.'.color(:yellow)
  puts 'License: MIT'.color(:yellow)
  puts 'Bugs: Please file bugs on http://saigkill.ddns.net:8112/dashboard'.color(:yellow)
  puts ''
  puts 'Permission is hereby granted, free of charge, to any person obtaining a copy'.color(:yellow)
  puts 'of this software and associated documentation files (the "Software"), to deal'.color(:yellow)
  puts 'in the Software without restriction, including without limitation the rights'.color(:yellow)
  puts 'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell'.color(:yellow)
  puts 'copies of the Software, and to permit persons to whom the Software is'.color(:yellow)
  puts 'furnished to do so, subject to the following conditions:'.color(:yellow)
  puts ''
  puts 'The above copyright notice and this permission notice shall be included in'.color(:yellow)
  puts 'all copies or substantial portions of the Software.'.color(:yellow)
  puts ''
  puts 'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR'.color(:yellow)
  puts 'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,'.color(:yellow)
  puts 'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE'.color(:yellow)
  puts 'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER'.color(:yellow)
  puts 'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,'.color(:yellow)
  puts 'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN'.color(:yellow)
  puts 'THE SOFTWARE.'.color(:yellow)

  # This method checks if a oldconfig is available
  # @return [String] true or false
  def self.oldconfig
    home = Dir.home
    if File.exist?("#{home}/.publicancreators.cfg")
      puts 'Found configuration file and using it...'.color(:yellow)
    else
      # @raise
      puts 'Please run rake setup'.color(:red)
      raise('Exiting now..').color(:red)
    end
  end

  # @note Check oldconfig
  oldconfig

  puts 'Reading the config file in ~/.publicancreators.cfg'
  # @note Run config method who reads in the config file and puts the variables in an array
  name, email, language, use_brand, title_logo, legal, brand, company_name, company_division, email_business,
      brand_dir, glob_entities, articles_dir_business, reports_dir_business, books_dir_business, articles_dir_private,
      homework_dir_private, books_dir_private, brand_private, brand_homework, db5, conf_ver, xfc_brand_dir,
      pdfview = PublicanCreatorsGet.config

  puts 'Your configuration is:'.color(:yellow)
  puts "Your Name: #{name}".color(:yellow)
  puts "Your private emailaddress: #{email}".color(:yellow)
  puts "Your choosen language: #{language}".color(:yellow)
  puts "Using an own brand: #{use_brand}".color(:yellow)
  puts "Leave title_logo: #{title_logo}".color(:yellow)
  puts "Leave legalnotice in article: #{legal}".color(:yellow)
  puts "Choosen brand: #{brand}".color(:yellow)
  puts "Your company name: #{company_name}".color(:yellow)
  puts "Your company division: #{company_division}".color(:yellow)
  puts "Your business email address: #{email_business}".color(:yellow)
  puts "Your brand dir: #{brand_dir}".color(:yellow)
  puts "Your global entities: #{glob_entities}".color(:yellow)
  puts "Your business articles dir: #{articles_dir_business}".color(:yellow)
  puts "Your business reports dir: #{reports_dir_business}".color(:yellow)
  puts "Your business books dir: #{books_dir_business}".color(:yellow)
  puts "Your private articles dir: #{articles_dir_private}".color(:yellow)
  puts "Your homework dir: #{homework_dir_private}".color(:yellow)
  puts "Your private books dir: #{books_dir_private}".color(:yellow)
  puts "Your private brand: #{brand_private}".color(:yellow)
  puts "Your homework brand: #{brand_homework}".color(:yellow)
  puts "DocBook5 as default: #{db5}".color(:yellow)
  puts "Config version: #{conf_ver}".color(:yellow)
  puts "XFC brand dir: #{xfc_brand_dir}".color(:yellow)
  puts "Your prefered PDF-Viewer: #{pdfview}".color(:yellow)

  global_entities = "#{brand_dir}/#{glob_entities}"
  puts "Your global entities file is there: #{global_entities}"

  # @note Ask for the title and other settings via yad and put them into a array
  environment, type, opt, title = PublicanCreatorsGet.title

  puts "Environment: #{environment}".color(:yellow)
  puts "Type: #{type}".color(:yellow)
  puts "Optional: #{opt}".color(:yellow)
  puts "Title: #{title}".color(:yellow)

  # This method sets the default value for report
  # @param [String] opt Can be Report or Homework or Normal
  # @return [String] report
  def self.defaults_report(opt)
    if opt == 'Report'
      report = 'TRUE'
    else
      report = 'FALSE'
    end
    return report
  end
  report = defaults_report(opt)

  # This method sets the default value for report
  # @param [String] opt Can be Report or Homework or Normal
  # @return [String] report
  def self.defaults_homework(opt)
    if opt == 'Homework'
      homework = 'TRUE'
    else
      homework = 'FALSE'
    end
    return homework
  end
  homework = defaults_homework(opt)

  # @note Hardcoded variables
  artinfo = "#{title}/#{language}/Article_Info.xml"
  bookinfo = "#{title}/#{language}/Book_Info.xml"
  revhist = "#{title}/#{language}/Revision_History.xml"
  agroup = "#{title}/#{language}/Author_Group.xml"
  ent = "#{title}/#{language}/#{title}.ent"
  builds = "#{title}/#{language}/Rakefile"

  # @note Run one of the both methods to get the variable targetdir
  # @param [String] type Book or Article
  # @param [String] reports_dir_business path to that dir where you store your reports
  # @param [String] articles_dir_business path to that dir where you store business articles
  # @param [String] report true or false
  # @param [String] books_dir_business path to that dir where you store your business books
  # @param [String] true or false
  # @param [String] articles_dir_private path to your private articles directory
  # @param [String] homework path to your homework directory
  # @param [String] books_dir_private path to your private books directory
  targetdir = PublicanCreatorsPrepare.prepare(environment, type, reports_dir_business, articles_dir_business, report, books_dir_business,homework, articles_dir_private, homework_dir_private, books_dir_private)

  # @note Checks if the needed directory targetdir is available. Otherwise it creates one.
  puts "Creating directory #{targetdir}".color(:yellow)
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or .prepare_private
  Checker.check_dir(targetdir)

  # @note Change to target directory
  puts 'Change to this directory'.color(:yellow)
  # @param [String] targetdir comes from PublicanCreatorsPrepare.prepare_work or .prepare_private
  FileUtils.cd(targetdir) do

    # @param [String] title comes from titleget[3]
    # @param [String] type Book or Article
    # @param [String] language comes from config file in format de-DE
    # @param [String] brand e.g. Debian or nothing for using publicans default brand (config file)
    # @param [String] db5 DocBook5 as default? (config file)
    # @param [String] homework true or false
    # @param [String] brand_homework e.g. ils (config file)
    # @param [String] brand_private e.g. manns (config file)
    PublicanCreatorsChange.check_environment(environment, title, type, language, brand, db5, homework, brand_homework, brand_private)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] global_entities path to a global entities file (config file)
    # @param [String] brand e.g. Debian or nothing for using publicans default brand (config file)
    PublicanCreatorsChange.add_entity(environment, global_entities, ent)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] company_name (config file)
    PublicanCreatorsChange.change_holder(title, environment, name, company_name, ent)

    # @param [String] title comes from titleget[3]
    # @param [String] environment Work or Private
    # @param [String] type Book or Article
    # @param [String] legal remove legalnotice from article? (config file)
    PublicanCreatorsChange.remove_legal(environment, type, legal, artinfo) #

    # @param [String] artinfo path to Article_Info (hardcoded)
    # @param [String] bookinfo path to Book_Info (hardcoded)
    # @param [String] title_logo remove titlelogo from articlepage (config file)
    # @param [String] type Book or Article
    PublicanCreatorsChange.remove_orgname(bookinfo, artinfo, title_logo, type)

    # @param [String] environment Work or Private
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] title comes from titleget[3]
    PublicanCreatorsChange.fix_revhist(environment, name, email_business, email, revhist)

    # @param [String] title comes from titleget[3]
    # @param [String] name your name (config file)
    # @param [String] email_business business email address (config file)
    # @param [String] company_name your company's name (config file)
    # @param [String] company_division your companiy's division
    # @param [String] email your private email address
    PublicanCreatorsChange.fix_authorgroup(name, email_business, company_name, company_division, email, environment, agroup)

    # @param [String] title comes from titleget[3]
    # @param [String] builds path to buildscript (hardcoded)
    # @param [String] language comes from config file in format de-DE
    # @param [String] xfc_brand_dir if present the path to your branded xfc stylesheets (config file)
    # @param [String] pdfview your prefered PDF-Viewer (config file)
    PublicanCreatorsExport.export_buildscript(title, builds, language, xfc_brand_dir, pdfview)

    puts "Now you can find your documentation there: #{targetdir}/#{title}".color(:yellow)

    puts "Thanks for using: #{my_name} #{version}".color(:yellow)
  end
end
