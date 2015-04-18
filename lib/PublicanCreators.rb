#!/usr/bin/env ruby
# Written by: Sascha Manns <Sascha.Manns@bdvb.de>
#
# Published under: See LICENSE file
require 'PublicanCreators/version'
require 'PublicanCreators/checker'
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

# Nach dem Titel und der Art fragen
titel = `yad --entry --button="Bestätigen" --title="Neuen Artikel erstellen" --text="Gebe ein Titel ein (Mit Unterstrichen statt Leerzeichen und ohne Umlaute):"`
#art = `yad --title="Artikelart auswählen" --text="Welcher Art ist dein Artikel?" --button="Report" --button="Normale-Dokumentation" --image=/usr/share/pixmaps/publican-xcom.png`

# Variablen
home = Dir.home
publican_doc_dir = "#{home}/Dokumente/Textdokumente/publican-dokumentation2"
publican_ver_get = `publican -v`
publican_ver = publican_ver_get.delete 'version='
articles_dir = "#{publican_doc_dir}/articles"
xcom_brand_dir = '/usr/share/publican/Common_Content/XCOM'
ent = "de-DE/#{titel}.ent"
artinfo = 'de-DE/Article_Info.xml'
revhist = 'de-DE/Revision_History.xml'
agroup = 'de-DE/Author_Group.xml'
builds = 'de-DE/build.sh'
gsbuha_docdir = 'Projekte/GSBUHA/Dokumentation'
reports_docdir = "#{gsbuha_docdir}/Reports"

# Checkt ob articles_dir exisitert. Wenn nicht, wird es erstellt
puts "Erstellt Verzeichnis #{articles_dir}/#{titel}"
$todo = "#{articles_dir}/#{titel}"
Checker::check_dir

# Wechsel in article Verzeichnis
puts 'Wechsle in article Verzeichnis'
FileUtils.cd("#{articles_dir}/#{titel}") do

  # Erstellung der Initialdokumentation mit Publican
  puts 'Erstelle Initialdokumentation ...'
  system("publican create --lang de-DE --brand XCOM --type Article --dtdver 5.0 --name #{titel}")
  puts Dir.pwd
  puts 'Füge globale XCOM Entities hinzu'
  # Globale Entitäten hinzufügen
  open("#{ent}", 'a') { |f|
    f << "\n"
    f << "<!-- XCOM COMMON ENTITIES -->\n"
  }
  input = File.open("#{xcom_brand_dir}/de-DE/entitiesxcom.ent")
  data_to_copy = input.read()
  output = File.open("#{ent}", 'w')
  output.write(data_to_copy)
  input.close
  output.close

  # Holder ersetzen
  puts 'Ersetze Standardtext durch richtigen Holder'
  text = File.read("#{ent}")
  new_contents = text.gsub("| You need to change the HOLDER entity in the de-DE/#{titel}.ent file |", "XCOM AG")
  puts new_contents
  File.open("#{ent}", 'w') { |file| file.puts new_contents }

  # Entferne Titelbild des Artikels
  puts 'Entferne Logo aus dem Article_Info File. Wird anders gesetzt.'
  io = File.open("#{artinfo}", 'r')
  doc = Nokogiri::XML(io)
  io.close
  doc.search('//orgname').each do |node|
    node.children.remove_instance_variable
    node.content = 'Children removed'
  end

  # Entferne Legal Notice wir nutzen eine andere
  puts 'Entferne Link zur Legalnotice, da wir sie anders einbinden'
  suchtext = %r{<xi:include href="Common_Content/Legal_Notice.xml" xmlns:xi="http://www.w3.org/2001/XInclude" />}
  File.open("#{artinfo}") do |file|
    file.each_line do |line|
      puts(line) unless line =~ suchtext
    end
  end
  if publican_ver == '2.8'
    # Revision_History: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Revision_History mit dem tatsächlichen'
    text = File.read("#{revhist}")
    vorname = text.gsub('Dude', 'Sascha')
    nachname = text.gsub('McPants', 'Manns')
    email = text.gsub('Dude.McPants@example.com', 'Sascha.Manns@xcom.de')
    member = text.gsub('Initial creation of book by publican', 'Initial creation')
    puts vorname
    puts nachname
    puts email
    puts member
    File.open("#{revhist}", 'w')

    # Author Group: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Author_Group mit dem tatsächlichen'
    text = File.read("#{agroup}")
    vorname = text.gsub('Dude', 'Sascha')
    nachname = text.gsub('McPants', 'Manns')
    org = text.gsub('Somewhere', 'XCOM AG')
    div = text.gsub('Someone', 'SWE 7 (Sascha Bochartz)')
    email = text.gsub('Dude.McPants@example.com', 'Sascha.Manns@xcom.de')
    puts vorname
    puts nachname
    puts org
    puts div
    puts email
    File.open("#{agroup}", 'w')
  else
    # Revision_History: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Revision_History mit dem tatsächlichen'
    text = File.read("#{revhist}")
    vorname = text.gsub('Enter your first name here.', 'Sascha')
    nachname = text.gsub('Enter your surname here.', 'Manns')
    email = text.gsub('Enter your email address here.', 'Sascha.Manns@xcom.de')
    member = text.gsub('Initial creation of book by publican', 'Initial creation')
    puts vorname
    puts nachname
    puts email
    puts member
    File.open("#{revhist}", 'w')

    # Author Group: Ändere vorbelegte Daten
    puts 'Ersetze Standarduser in Author_Group mit dem tatsächlichen'
    text = File.read("#{agroup}")
    vorname = text.gsub('Enter your first name here.', 'Sascha')
    nachname = text.gsub('Enter your surname here.', 'Manns')
    email = text.gsub('Enter your email address here.', 'Sascha.Manns@xcom.de')
    org = text.gsub('Enter your organisation\'s name here.', 'XCOM AG')
    div = text.gsub('Enter your organisational division here.', 'SWE 7 (Sascha Bochartz)')
    puts vorname
    puts nachname
    puts org
    puts div
    puts email
    File.open("#{agroup}", 'w')
  end

  # Shellscriptoutput oder Modifikation
  puts 'Exportiere Build-Shellscript in das neue Verzeichnis'
  FileUtils.touch "#{builds}"
  File.write "#{builds}", <<EOF
#!/bin/bash
# Description: This script builds PDF, DOCX, ODT, RTF and WML
# Usage: build.sh [-docx] [-odt] [-rtf] [-wml] [-pdf]
# Version:
# 0.1 initial version
# Functions
usage() {
echo "usage: $0 [-docx] [-odt] [-rtf] [-wml] [-pdf] [-html]..."
echo
echo "Optionen: "
echo "-docx : Export der Docbook Source nach DOCX"
echo " Beispiel: $0 -docx"
echo "-odt : Export der Docbook Source nach ODT"
echo " Beispiel: $0 -odt"
echo "-rtf : Export der Docbook Source nach RTF"
echo " Beispiel: $0 -rtf"
echo "-wml: Export der Docbook Source nach WML"
echo " Beispiel: $0 -wml"
echo "-pdf: Export der Docbook Source nach PDF"
echo " Beispiel: $0 -pdf"
echo "-html: Export der Docbook Source nach HTML"
echo " Beispiel: $0 -html"
echo "-man: Export der Docbook Source nach MAN"
echo " Beispiel: $0 -man"
echo "-txt: Export der Docbook Source nach TXT"
echo " Beispiel: $0 -txt"
echo "-epub: Export der Docbook Source nach EPUB"
echo " Beispiel: $0 -epub"
exit 1
}

# main
case "$1" in
    -docx)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{titel}.xml -o #{titel}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{titel}.fo #{titel}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{titel}-resolved.xml
        echo "Führe Transformation nach DOCX durch"
        fo2docx #{titel}.fo > #{titel}.docx
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{titel}.docx &
        ;;
    -odt)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{titel}.xml -o #{titel}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{titel}.fo #{titel}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{titel}-resolved.xml
        echo "Führe Transformation nach ODT durch"
        fo2odt #{titel}.fo > #{titel}.odt
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{titel}.odt &
        ;;
    -rtf)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{titel}.xml -o #{titel}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{titel}.fo #{titel}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{titel}-resolved.xml
        echo "Führe Transformation nach RTF durch"
        fo2rtf #{titel}.fo > #{titel}.rtf
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{titel}.rtf &
        ;;
    -wml)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{titel}.xml -o #{titel}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{titel}.fo #{titel}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{titel}-resolved.xml
        echo "Führe Transformation nach WML durch"
        fo2wml #{titel}.fo > #{titel}.wml
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{titel}.wml &
        ;;
    -pdf)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach PDF"
        publican build --langs=de-DE --formats=pdf --allow_network
        echo "Starte PDF-Betrachter"
        /opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app PDFXCview.exe tmp/de-DE/pdf/*.pdf &
        ;;
    -html)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=de-DE --formats=html --allow_network
        echo "Starte Browser"
        firefox tmp/de-DE/html/index.html &
        ;;
    -man)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach MAN"
        publican build --langs=de-DE --formats=man --allow_network
        ;;
     -txt)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=de-DE --formats=txt --allow_network
        echo "Starte Texteditor"
        gedit tmp/de-DE/txt/*.txt &
        ;;
     -epub)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach EPUB"
        publican build --langs=de-DE --formats=epub --allow_network
        echo "Starte EPUB-Betrachter"
        ebook-viewer tmp/de-DE/*.epub &
        ;;
      -eclipse)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=de-DE --formats=eclipse --allow_network
        ;;
    *)
        usage
esac
exit 0
EOF

  # Buildscript ausführbar machen
  puts 'Mache Buildscript ausführbar ...'
  FileUtils.chmod 'u=rwx,go=rwx', "#{builds}"

  # Hinweis wegen Umlauten
  system('yad --info --text="Enthält der Titel normalerweise Umlaute, dann ergänze die publican.cfg deines Projektes z.B. mit: \'docname: JER_Ertragnisaufstellung_Kunde\'. Anschließend kann innerhalb der Article_Info.xml oder Book_Info.xml der Titel innerhalb der \'title\' tags mit Umlauten eingegeben werden."')

  # Verschiebe erzeugtes Verzeichnis
  puts 'Verschiebe Verzeichnis an den richtigen Platz'
  if art == '0'
    FileUtils.mv "#{titel}", "#{reports_docdir}"
  else
    FileUtils.mv "#{titel}", "#{gsbuha_docdir}"
  end

  puts "Vielen Dank für die Benutzung von #{my_name} #{version}"
end

