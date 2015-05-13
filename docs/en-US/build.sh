#!/bin/bash
# Description: This script builds PDF, DOCX, ODT, RTF and WML
# Usage: build.sh [-docx] [-odt] [-rtf] [-wml] [-pdf]
# Version:
# 0.1 initial version
# Functions
usage() {
echo "usage: /usr/bin/create-article.sh [-docx] [-odt] [-rtf] [-wml] [-pdf] [-html]..."
echo
echo "Optionen: "
echo "-docx : Export der Docbook Source nach DOCX"
echo " Beispiel: /usr/bin/create-article.sh -docx"
echo "-odt : Export der Docbook Source nach ODT"
echo " Beispiel: /usr/bin/create-article.sh -odt"
echo "-rtf : Export der Docbook Source nach RTF"
echo " Beispiel: /usr/bin/create-article.sh -rtf"
echo "-wml: Export der Docbook Source nach WML"
echo " Beispiel: /usr/bin/create-article.sh -wml"
echo "-pdf: Export der Docbook Source nach PDF"
echo " Beispiel: /usr/bin/create-article.sh -pdf"
echo "-html: Export der Docbook Source nach HTML"
echo " Beispiel: /usr/bin/create-article.sh -html"
echo "-man: Export der Docbook Source nach MAN"
echo " Beispiel: /usr/bin/create-article.sh -man"
echo "-txt: Export der Docbook Source nach TXT"
echo " Beispiel: /usr/bin/create-article.sh -txt"
echo "-epub: Export der Docbook Source nach EPUB"
echo " Beispiel: /usr/bin/create-article.sh -epub"
exit 1
}

# main
case "$1" in
    -docx)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude PublicanCreators.xml -o PublicanCreators-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o PublicanCreators.fo PublicanCreators-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm PublicanCreators-resolved.xml
        echo "Führe Transformation nach DOCX durch"
        fo2docx PublicanCreators.fo > PublicanCreators.docx
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter PublicanCreators.docx &
        ;;
    -odt)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude PublicanCreators.xml -o PublicanCreators-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o PublicanCreators.fo PublicanCreators-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm PublicanCreators-resolved.xml
        echo "Führe Transformation nach ODT durch"
        fo2odt PublicanCreators.fo > PublicanCreators.odt
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter PublicanCreators.odt &
        ;;
    -rtf)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude PublicanCreators.xml -o PublicanCreators-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o PublicanCreators.fo PublicanCreators-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm PublicanCreators-resolved.xml
        echo "Führe Transformation nach RTF durch"
        fo2rtf PublicanCreators.fo > PublicanCreators.rtf
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter PublicanCreators.rtf &
        ;;
    -wml)
        echo "Auflösung aller XML-Entities und XI-XIncludes"
        xmllint --noent --dropdtd --xinclude PublicanCreators.xml -o PublicanCreators-resolved.xml
        echo "Formatiere XML nach XSL-FO"
        saxon-xslt -o PublicanCreators.fo PublicanCreators-resolved.xml /opt/XMLmind/xfc-xcom-stylesheet/xsl/fo/docbook.xsl
        rm PublicanCreators-resolved.xml
        echo "Führe Transformation nach WML durch"
        fo2wml PublicanCreators.fo > PublicanCreators.wml
        echo "Starte LibreOffice Writer zur Ansicht"
        lowriter PublicanCreators.wml &
        ;;
    -pdf)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Rormatiere Docbook Dokument und rendere es nach PDF"
        publican build --langs=en-US --formats=pdf --allow_network
        echo "Starte PDF-Betrachter"
        /opt/cxoffice/bin/wine --bottle "PDF-XChange Viewer 2.x" --cx-app PDFXCview.exe tmp/en-US/pdf/*.pdf &
        ;;
    -html)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Rormatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=en-US --formats=html --allow_network
        echo "Starte Browser"
        firefox tmp/en-US/html/index.html &
        ;;
    -man)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Rormatiere Docbook Dokument und rendere es nach MAN"
        publican build --langs=en-US --formats=man --allow_network
        ;;
     -txt)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Rormatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=en-US --formats=txt --allow_network
        echo "Starte Texteditor"
        gedit tmp/en-US/txt/*.txt &
        ;;
     -epub)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Formatiere Docbook Dokument und rendere es nach EPUB"
        publican build --langs=en-US --formats=epub --allow_network
        echo "Starte EPUB-Betrachter"
        ebook-viewer tmp/en-US/*.epub &
        ;;
      -eclipse)
        cd ..
        echo "Räume temporäres Verzeichnis auf"
        publican clean
        echo "Rormatiere Docbook Dokument und rendere es nach HTML"
        publican build --langs=en-US --formats=eclipse --allow_network
        ;;
    *)
        usage
esac
exit 0
