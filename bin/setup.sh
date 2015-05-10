#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "##################################################################################"
echo "#                  PublicanCreators Setup                                        #"
echo "##################################################################################"
echo "Install Bundle"
gem install bundler
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
distver=`lsb_release -rs | cut -c1-2`
if [ "$distro" == 'Ubuntu' ]
then
    echo "Found Ubuntu"
    if [ "$distver" -lt "14" ]
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
    cp ../lib/PublicanCreators/.publicancreators.cfg $HOME/.publicancreators.cfg.new
    echo "The actual config file was placed in $HOME/.publicancreators.cfg.new"
    echo "Please check if new parameters are shipped. If any are missed in your old config please add them into your file. Then remove $HOME/.publicancretors.cfg.new"
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
if [ -e /usr/bin/publicancreators ]
then
    rm /usr/bin/publicancreators
fi
sudo ln -s ${FROM}/PublicanCreators.rb /usr/bin/publicancreators

if [ -e /usr/bin/publicancreators-rev ]
then
    rm /usr/bin/publicancreators-rev
fi
sudo ln -s ${FROM}/RevisionCreator.rb /usr/bin/publicancreators-rev

echo "Creating Desktop file"
if [ -e $HOME/.local/share/applications/publicancreators.desktop ]
then
    # @todo In earlier version i used sudo cat for creating the desktop file. Its not needed because its in user dir. Remove sudo later.
    sudo rm $HOME/.local/share/applications/publicancreators.desktop
fi
cat <<EOF > $HOME/.local/share/applications/publicancreators.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=/usr/bin/publicancreators
Icon=${FROM}/publican.png
EOF
if [ -e $HOME/.local/share/applications/publicancreators-rev.desktop ]
then
    rm $HOME/.local/share/applications/publicancreators-rev.desktop
fi
sudo cat <<EOF > $HOME/.local/share/applications/publicancreators-rev.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreatorsRevision
Exec=/usr/bin/publicancreators-rev
Icon=${FROM}/publican-revision.png
EOF


# Do any other automated setup that you need to do here
