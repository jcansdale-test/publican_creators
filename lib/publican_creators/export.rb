# Copyright (C) 2013-2019 Sascha Manns <Sascha.Manns@outlook.de>
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

require_relative 'change'
require 'fileutils'
require 'rainbow/ext/string'
# Module for running exports to a file
module PublicanCreatorsExport
  # Exports a predefined Shellscript to the target directory.
  # It returns a sucess or fail.
  # Description:
  # @param [String] title comes from the get method. This parameter represents
  #                 the name or title of your work. It is used in all important
  #                 code places.
  # @param [String] builds is the path to your buildscript
  # @param [String] language is just the ISO Code of your target language
  #                 like: en-GB or such things.
  # @param [String] xfc_brand_dir if present the path to your branded xfc
  #                 stylesheets (config file)
  # @param [String] pdfview your prefered PDF-Viewer (config file)
  # @return [String] true or false
  def self.export_buildscript(title, builds, language, xfc_brand_dir, pdfview)
    puts 'Export the buildscript into new directory...'
    FileUtils.touch builds.to_s
    # rubocop:disable Layout/IndentHeredoc
    File.write builds.to_s, <<BUILDSCRIPT
# -*- ruby -*-
# encoding: utf-8
require 'fileutils'

task :default do
  puts 'usage: rake [export_docx] [export_odt] [export_rtf] [export_wml] [export_pdf] [export_html] [export_man] [export_txt] [export_txt] [export_epub]'
  puts
  puts 'Options:'
  puts 'export_docx : Export DocBook source to DOCX'
  puts ' Example: rake export_docx'
  puts 'export_odt : Export DocBook source to ODT'
  puts ' Example: rake export_odt'
  puts 'export_rtf : Export DocBook source to RTF'
  puts ' Example: rake export_rtf'
  puts 'export_wml: Export DocBook source to WML'
  puts ' Example: rake export_wml'
  puts 'export_pdf: Export Docbook source to PDF'
  puts ' Example: rake export_pdf'
  puts 'export_html: Export DocBook source to HTML'
  puts ' Example: rake export_html'
  puts 'export_man: Export DocBook source to MAN'
  puts ' Example: rake export_man'
  puts 'export_txt: Export DocBook source to TXT'
  puts ' Example: rake export_txt'
  puts 'export_epub: Export DocBook source to EPUB'
  puts ' Example: rake export_epub'
  puts 'export_eclipse: Export DocBook source to Eclipse Help'
  puts ' Example: rake export_eclipse'
end

require 'dir'
require 'fileutils'
desc 'Checks if temp dir is available. Otherwise it creates it'
task :checker do
  todos = "../tmp/#{language}/docx"
  if Dir.exist?(todos)
    puts 'Found directory. Im using it.'
  else
    puts 'No directory found. Im creating it.'
    FileUtils.mkdir_p(todos)
  end
  todos = "../tmp/#{language}/odt"
  if Dir.exist?(todos)
    puts 'Found directory. Im using it.'
  else
    puts 'No directory found. Im creating it.'
    FileUtils.mkdir_p(todos)
  end
  todos = "../tmp/#{language}/rtf"
  if Dir.exist?(todos)
    puts 'Found directory. Im using it.'
  else
    puts 'No directory found. Im creating it.'
    FileUtils.mkdir_p(todos)
  end
  todos = "../tmp/#{language}/wml"
  if Dir.exist?(todos)
    puts 'Found directory. Im using it.'
  else
    puts 'No directory found. Im creating it.'
    FileUtils.mkdir_p(todos)
  end
end

desc 'Convert to DOCX'
task :export_docx => [:checker] do
  puts 'Resolving all XML-Entities and XI-Includes'
  system("xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml")
  puts 'Formatting XML to XSL-FO'
  system("saxon-xslt -o #{title}.fo #{title}-resolved.xml #{xfc_brand_dir}")
  puts 'Removing temporary resolved file'
  FileUtils.rm('#{title}-resolved.xml')
  puts 'Transforming to DOCX'
  system("fo2docx #{title}.fo > ../tmp/#{language}/docx/#{title}.docx")
  puts 'Launching LibreOffice Writer for Preview'
  system("lowriter ../tmp/#{language}/docx/#{title}.docx &")
end

desc 'Convert to ODT'
task :export_odt => [:checker] do
  puts 'Resolving all XML-Entities and XI-Includes'
  system("xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml")
  puts 'Formatting XML to XSL-FO'
  system("saxon-xslt -o #{title}.fo #{title}-resolved.xml #{xfc_brand_dir}")
  puts 'Removing temporary resolved file'
  FileUtils.rm('#{title}-resolved.xml')
  puts 'Transforming to ODT'
  system("fo2odt #{title}.fo > ../tmp/#{language}/odt/#{title}.odt")
  puts 'Launching LibreOffice Writer for Preview'
  system("lowriter ../tmp/#{language}/odt/#{title}.odt &")
end

desc 'Convert to RTF'
task :export_rtf => [:checker] do
  puts 'Resolving all XML-Entities and XI-Includes'
  system("xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml")
  puts 'Formatting XML to XSL-FO'
  system("saxon-xslt -o #{title}.fo #{title}-resolved.xml #{xfc_brand_dir}")
  puts 'Removing temporary resolved file'
  FileUtils.rm('#{title}-resolved.xml')
  puts 'Transforming to RTF'
  system("fo2rtf #{title}.fo > ../tmp/#{language}/rtf/#{title}.rtf")
  puts 'Launching LibreOffice Writer for Preview'
  system("lowriter ../tmp/#{language}/rtf/#{title}.rtf &")
end

desc 'Convert to WML'
task :export_wml => [:checker] do
  puts 'Resolving all XML-Entities and XI-Includes'
  system("xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml")
  puts 'Formatting XML to XSL-FO'
  system("saxon-xslt -o #{title}.fo #{title}-resolved.xml #{xfc_brand_dir}")
  puts 'Removing temporary resolved file'
  FileUtils.rm('#{title}-resolved.xml')
  puts 'Transforming to WML'
  system("fo2wml #{title}.fo > ../tmp/#{language}/wml/#{title}.wml")
end

desc 'Convert to PDF'
task :export_pdf do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to PDF'
  system('publican build --langs=#{language} --formats=pdf --allow_network')
  puts 'Launching PDF-Viewer'
  system('#{pdfview} tmp/#{language}/pdf/*.pdf &')
end

desc 'Convert to HTML'
task :export_html do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to PDF'
  system('publican build --langs=#{language} --formats=html --allow_network')
  puts 'Launching Browser'
  system('firefox tmp/#{language}/html/index.html &')
end

desc 'Convert to MAN'
task :export_man do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to MAN'
  system('publican build --langs=#{language} --formats=man --allow_network')
end

desc 'Convert to TXT'
task :export_txt do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to TXT'
  system('publican build --langs=#{language} --formats=txt --allow_network')
  puts 'Launching Texteditor'
  system('gedit tmp/#{language}/txt/*.txt &')
end

desc 'Convert to EPUB'
task :export_epub do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to EPUB'
  system('publican build --langs=#{language} --formats=epub --allow_network')
  if File.exist?('/usr/bin/ebook-viewer')
    puts 'Launching EPUB-Viewer'
    system('ebook-viewer /tmp/#{language}/*.epub &')
  else
    puts 'You have to install calibre for using ebook-viewer for preview'
  end
end

desc 'Convert to ECLIPSE'
task :export_eclipse do
  FileUtils.cd('..')
  puts 'Cleaning up temp directory'
  system('publican clean')
  puts 'Formatting to ECLIPSE'
  system('publican build --langs=#{language} --formats=eclipse --allow_network')
end

desc 'Run convert to most used formats'
task :export_most => [:export_docx, :export_odt, :export_rtf, :export_html, :export_pdf] do
  puts 'Successful exported to DOCX, ODT, RTF, HTML and PDF'
end

desc 'Run convert to all formats'
task :export_all => [:export_most, :export_wml, :export_man, :export_txt, :export_epub, :export_eclipse] do
  puts 'Successfull exported to all formats'
end
BUILDSCRIPT
  end
end
