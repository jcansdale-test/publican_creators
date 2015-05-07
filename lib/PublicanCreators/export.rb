# Export-Module for PublicanCreators
# It produces a shell script for simplify the build process
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

require 'PublicanCreators/change'
require 'fileutils'

# Module for running exports to a file
module PublicanCreatorsExport

  # Exports a predefined Shellscript to the target directory.
  # It returns a sucess or fail.
  # Description:
  # @param title [String] comes from the get method. This parameter represents the name or title of your work. It is used in all important code places.
  # @param builds [String] is the path to your buildscript
  # @param language [String] is just the ISO Code of your target language like: de-DE, en-GB or such things.
  # @return [bool] true or false
  def self.export_buildscript(title, builds, language)
    puts 'Export the buildscript into new directory...'
    FileUtils.touch "#{builds}"
    File.write "#{builds}", <<EOF
#!/bin/bash
# Description: This script builds PDF, DOCX, ODT, RTF, HTML, MAN, TXT, EPUB and WML
# Usage: $0 [-docx] [-odt] [-rtf] [-wml] [-pdf] [-html] [-man] [-txt] [-epub]
# Version:
# 0.1 initial version
# Functions
usage() {
echo "usage: $0 [-docx] [-odt] [-rtf] [-wml] [-pdf] [-html] [-man] [-txt] [-epub]"
echo
echo "Options: "
echo "-docx : Export DocBook source to DOCX"
echo " Example: $0 -docx"
echo "-odt : Export DocBook source to ODT"
echo " Example: $0 -odt"
echo "-rtf : Export DocBook source to RTF"
echo " Example: $0 -rtf"
echo "-wml: Export DocBook source to WML"
echo " Example: $0 -wml"
echo "-pdf: Export Docbook source to PDF"
echo " Example: $0 -pdf"
echo "-html: Export DocBook source to HTML"
echo " Example: $0 -html"
echo "-man: Export DocBook source to MAN"
echo " Example: $0 -man"
echo "-txt: Export DocBook source to TXT"
echo " Example: $0 -txt"
echo "-epub: Export DocBook source to EPUB"
echo " Example: $0 -epub"
exit 1
}

# main
case "$1" in
    -docx)
        echo "Solve all XML-Entities and XI-Includes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatting XML to XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Transforming to DOCX"
        fo2docx #{title}.fo > #{title}.docx
        echo "Launching LibreOffice Writer"
        lowriter #{title}.docx &
        ;;
    -odt)
        echo "Solve all XML-Entities and XI-Includes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatting XML to XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Transforming to ODT"
        fo2odt #{title}.fo > #{title}.odt
        echo "Starting LibreOffice Writer"
        lowriter #{title}.odt &
        ;;
    -rtf)
        echo "Solve all XML-Entities and XI-Includes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatting XML to XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Transforming to RTF"
        fo2rtf #{title}.fo > #{title}.rtf
        echo "Launching LibreOffice Writer"
        lowriter #{title}.rtf &
        ;;
    -wml)
        echo "Solve all XML-Entities and XI-Includes"
        xmllint --noent --dropdtd --xinclude #{title}.xml -o #{title}-resolved.xml
        echo "Formatting XML to XSL-FO"
        saxon-xslt -o #{title}.fo #{title}-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm #{title}-resolved.xml
        echo "Transforming to WML"
        fo2wml #{title}.fo > #{title}.wml
        echo "Launching LibreOffice Writer"
        lowriter #{title}.wml &
        ;;
    -pdf)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting DocBook dokument and rendering to PDF"
        publican build --langs=#{language} --formats=pdf --allow_network
        echo "Launching PDF-Viewer"
        /opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app PDFXCview.exe tmp/de-DE/pdf/*.pdf &
        ;;
    -html)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting DocBook dokument and rendering to HTML"
        publican build --langs=#{language} --formats=html --allow_network
        echo "Launching Browser"
        firefox tmp/de-DE/html/index.html &
        ;;
    -man)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting DocBook document to MAN"
        publican build --langs=#{language} --formats=man --allow_network
        ;;
    -txt)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting DocBook document to TXT"
        publican build --langs=#{language} --formats=txt --allow_network
        echo "Launching Texteditor"
        gedit tmp/de-DE/txt/*.txt &
        ;;
    -epub)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting and rendering DocBook document to EPUB"
        publican build --langs=#{language} --formats=epub --allow_network
        echo "Launching EPUB-Viewer"
        ebook-viewer tmp/de-DE/*.epub &
        ;;
    -eclipse)
        cd ..
        echo "Cleanup temp directory"
        publican clean
        echo "Formatting to HTML"
        publican build --langs=#{language} --formats=eclipse --allow_network
        ;;
    *)
        usage
esac
exit 0
EOF
  end
end