#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "##################################################################################"
echo "#                  PublicanCreators Setup                                        #"
echo "##################################################################################"
echo "Install Bundle"
bundle install

# Fix for PC-6
echo  "Checking where i am"
if [ -f /etc/fedora-release ]
then
    echo "found Fedora"
    sudo yum install publican*
fi

if [ -f /etc/redhat-release ]
then
    echo "found Redhat"
    sudo yum install publican*
fi

distro=`lsb_release -is`
distver=`lsb_release -rs`
if [ "$distro" == 'Ubuntu' ]
then
    echo "Found Ubuntu"
    if [ "$distver" -lt "14.04" ]
    then
        echo "You need a Ubuntu version 14.04 or newer to use PublicanCreators"
    else
        sudo apt-get install publican yad
        sudo add-apt-repository ppa:sascha-manns-h/publican -y
        sudo apt-get update
        sudo apt-get install --only-upgrade publican
    fi
fi

if [ "$distro" == 'Debian' ]
then
    echo "Found Debian"
    echo "Can't prepare publican for Debian. Maybe i'm preparing a setup routine later."
    echo "You can try to install publican with this Howto: http://bit.ly/1dQtGLa"
fi

if [ -f /etc/SuSE-release ]
then
    echo "Found openSUSE"
    echo "Can't prepare publican for openSUSE because there are no packages."
    echo "You can try to install publican with this Howto: http://bit.ly/1dQtGLa"
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
    ${EDITOR} $HOME/.publicancreators.cfg
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
