#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "##################################################################################"
echo "#                  PublicanCreators Setup                                        #"
echo "##################################################################################"
echo "Install Bundle"
bundle install

echo  "Checking where i am"
YUM=`which yum`
if [ "$YUM" ]
then
echo "found yum"
sudo yum install publican*
fi

APT=`which apt-get`
if [ "$APT" ]
then
echo "Found apt-get"
sudo apt-get install publican yad
sudo add-apt-repository ppa:sascha-manns-h/publican -y
sudo apt-get update
sudo apt-get install --only-upgrade publican
fi

if [ -e $HOME/.publicancreators.cfg ]
then
    echo "Found Config file"
else
    echo "Creating Config file"
    cp ../lib/PublicanCreators/.publicancreators.cfg $HOME
    if [ -e /usr/bin/gedit ]
    then
        EDITOR="gedit"
    elif [ -e /usr/bin/kate ]
    then
        EDITOR="kate"
    elif [ -e /usr/bin/mousepad ]
    then
        EDITOR="mousepad"
    elif [ -e /usr/bin/geany ]
    then
        EDITOR="geany"
    elif [ -e /usr/bin/jedit ]
    then
        EDITOR="jedit"
    fi
    ${EDITOR} $HOME/.publicancreators
fi

echo "Linking binary"
FROM="$(pwd)"
sudo ln -s ${FROM}/PublicanCreators.rb /usr/bin/publicancreators

echo "Creating Desktop file"
sudo cat <<EOF > $HOME/.local/share/applications/publicancreators.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=/usr/bin/publicancreators
Icon=${FROM}/publican.png
EOF



# Do any other automated setup that you need to do here
