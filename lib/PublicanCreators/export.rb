require 'PublicanCreators/change'
require 'fileutils'

module PublicanCreatorsExport

  # Exports a predefined Shellscript to the target directory.
  def self.export_buildscript(title, builds, language)
    puts 'Export the buildscript into new directory...'
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
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Führe Transformation nach DOCX durch"
        fo2docx #{title}.fo > #{title}.docx
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{title}.docx &
        ;;
    -odt)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Führe Transformation nach ODT durch"
        fo2odt #{title}.fo > #{title}.odt
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{title}.odt &
        ;;
    -rtf)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Führe Transformation nach RTF durch"
        fo2rtf #{title}.fo > #{title}.rtf
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{title}.rtf &
        ;;
    -wml)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Führe Transformation nach WML durch"
        fo2wml #{title}.fo > #{title}.wml
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter #{title}.wml &
        ;;
    -pdf)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach PDF"
        publican build --langs=#{language} --formats=pdf --allow_network
        echo "Starte PDF-Betrachter"
        /opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app PDFXCview.exe tmp/de-DE/pdf/*.pdf &
        ;;
    -html)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=#{language} --formats=html --allow_network
        echo "Starte Browser"
        firefox tmp/de-DE/html/index.html &
        ;;
    -man)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach MAN"
        publican build --langs=#{language} --formats=man --allow_network
        ;;
     -txt)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=#{language} --formats=txt --allow_network
        echo "Starte Texteditor"
        gedit tmp/de-DE/txt/*.txt &
        ;;
     -epub)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach EPUB"
        publican build --langs=#{language} --formats=epub --allow_network
        echo "Starte EPUB-Betrachter"
        ebook-viewer tmp/de-DE/*.epub &
        ;;
      -eclipse)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=#{language} --formats=eclipse --allow_network
        ;;
    *)
        usage
esac
exit 0
EOF
  end
end