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

titelget = PublicanCreatorsGet.get_title
umgebung = titelget[0] # Dienstlich oder Privat
typ = titelget[1] # Artikel oder Buch
opt = titelget[2] # Report oder ILS
titel = titelget[3] # Titel

puts "Umgebung: #{umgebung}"
puts "Typ: #{typ}"
puts "Opt: #{opt}"
puts "Titel: #{titel}"

if opt == 'Report'
  report = 'TRUE'
else
  report = 'FALSE'
end
if opt == 'ILS'
  ils = 'TRUE'
else
  ils = 'FALSE'
end

devel = 'true'
# Variablen
if devel == 'true'
  target = 'publican-dokumentation2'
  target_manns = 'publican-manns2'
else
  target = 'publican-dokumentation'
  target_manns = 'publican-manns'
end

home = Dir.home
if umgebung == 'Dienstlich'
  if report == 'TRUE'
    articles_dir = "#{home}/Dokumente/Textdokumente/#{target}/articles/Projekte/GSBUHA/Dokumentation/Reports/"
  else
    articles_dir = "#{home}/Dokumente/Textdokumente/#{target}/articles/Projekte/GSBUHA/Dokumentation/"
  end
  books_docdir = "#{home}/Dokumente/Textdokumente/#{target}/books"
else
  if ils == 'FALSE'
    articles_dir = "#{home}/Dokumente/Textdokumente/#{target_manns}/articles"
  else
    articles_dir = "#{home}/Dokumente/Textdokumente/#{target_manns}/articles/ils"
  end
  books_docdir = "#{home}/Dokumente/Textdokumente/#{target_manns}/books"
end

artinfo = "#{titel}/de-DE/Article_Info.xml"
bookinfo = "#{titel}/de-DE/Book_Info.xml"
revhist = "#{titel}/de-DE/Revision_History.xml"
agroup = "#{titel}/de-DE/Author_Group.xml"
builds = "#{titel}/de-DE/build.sh"
ent = "#{titel}/de-DE/#{titel}.ent"

if typ == 'Artikel'
  todo = "#{articles_dir}"
else
  todo = "#{books_docdir}"
end

# Checkt ob articles_dir exisitert. Wenn nicht, wird es erstellt
puts "Erstellt Verzeichnis #{todo}"
Checker.check_dir(todo)

# Wechsel in article Verzeichnis
puts 'Wechsle in article Verzeichnis'
FileUtils.cd(todo) do

  PublicanCreatorsChange.init_doku(titel, umgebung, typ, ils)

  PublicanCreatorsChange.add_entity(ent, umgebung)

  PublicanCreatorsChange.change_holder(titel, ent, umgebung)

  PublicanCreatorsChange.remove_legal(artinfo, umgebung, typ)

  if typ == 'Artikel'
    PublicanCreatorsChange.remove_orgname(artinfo, umgebung)
  else
    PublicanCreatorsChange.remove_orgname(bookinfo, umgebung)
  end

  PublicanCreatorsChange.fix_revhist(revhist, umgebung)

  PublicanCreatorsChange.fix_authorgroup(agroup, umgebung)

  PublicanCreatorsExport.export_buildscript(titel)

  PublicanCreatorsChange.make_buildscript_exe(builds)

  puts "Sie finden Ihre Dokumentation unter #{articles_dir}/#{titel}"

  puts "Vielen Dank für die Benutzung von #{my_name} #{version}"
end