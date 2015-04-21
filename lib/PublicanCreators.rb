#!/usr/bin/env ruby
# Written by: Sascha Manns <Sascha.Manns$bdvb.de>
#
# Published under: See LICENSE file
require 'PublicanCreators/version'
require 'PublicanCreators/checker'
require 'PublicanCreators/get'
require 'PublicanCreators/change'
require 'PublicanCreators/export'
require 'fileutils'
require 'tempfile'
require 'nokogiri'
require 'rainbow/ext/string'
require 'bundler/setup'

my_name = 'PublicanCreators.rb'
version = PublicanCreators::VERSION

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

titel = PublicanCreatorsGet.get_title
titel = titel[0]
report = titel[1]
book = titel[2]

# Variablen
home = Dir.home
articles_dir = "#{home}/Dokumente/Textdokumente/publican-dokumentation2/articles/Projekte/GSBUHA/Dokumentation/"
reports_docdir = "#{home}/Dokumente/Textdokumente/publican-dokumentation2/articles/Projekte/GSBUHA/Dokumentation/Reports/"
books_docdir = "#{home}/Dokumente/Textdokumente/publican-dokumentation2/books"

artinfo = "#{titel}/de-DE/Article_Info.xml"
bookinfo = "#{titel}/de-DE/Book_Info.xml"
revhist = "#{titel}/de-DE/Revision_History.xml"
agroup = "#{titel}/de-DE/Author_Group.xml"
builds = "#{titel}/de-DE/build.sh"
ent = "#{titel}/de-DE/#{titel}.ent"

if book == 'FALSE'
  # Checkt ob articles_dir exisitert. Wenn nicht, wird es erstellt
  puts "Erstellt Verzeichnis #{articles_dir}"
  Checker.check_dir(articles_dir)

  # Wechsel in article Verzeichnis
  puts 'Wechsle in article Verzeichnis'
  FileUtils.cd(articles_dir) do

    PublicanCreatorsChange.init_doku(titel)

    PublicanCreatorsChange.add_entity(ent)

    PublicanCreatorsChange.change_holder(titel)

    PublicanCreatorsChange.remove_legal(artinfo)

    PublicanCreatorsChange.remove_orgname(artinfo)

    PublicanCreatorsChange.fix_revhist(revhist)

    PublicanCreatorsChange.fix_authorgroup(agroup)

    PublicanCreatorsExport.export_buildscript(titel)

    PublicanCreatorsChange.make_buildscript_exe(builds)

    # Verschiebe erzeugtes Verzeichnis
    puts 'Verschiebe Verzeichnis an den richtigen Platz'
    if report == 'TRUE'
      Checker.check_dir(reports_docdir)
      FileUtils.mv "#{titel}", "#{reports_docdir}"
      puts "Sie finden Ihre Dokumentation unter #{reports_docdir}/#{titel}"
    else
      puts "Sie finden Ihre Dokumentation unter #{articles_dir}/#{titel}"
    end
  end

else
  # Checkt ob articles_dir exisitert. Wenn nicht, wird es erstellt
  puts "Erstellt Verzeichnis #{books_docdir}"
  Checker.check_dir(books_docdir)

  # Wechsel in article Verzeichnis
  puts 'Wechsle in article Verzeichnis'
  FileUtils.cd(books_docdir) do

    PublicanCreatorsChange.init_doku_book(titel)

    PublicanCreatorsChange.add_entity(ent)

    PublicanCreatorsChange.change_holder(titel)

    PublicanCreatorsChange.remove_orgname(bookinfo)

    PublicanCreatorsChange.fix_revhist(revhist)

    PublicanCreatorsChange.fix_authorgroup(agroup)

    PublicanCreatorsExport.export_buildscript(titel)

    PublicanCreatorsChange.make_buildscript_exe(builds)

    puts "Sie finden Ihre Dokumentation unter #{books_docdir}/#{titel}"
  end
end

puts "Vielen Dank für die Benutzung von #{my_name} #{version}"
