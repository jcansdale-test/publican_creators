#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

bundle install
sudo apt-get install publican yad
sudo add-apt-repository ppa:sascha-manns-h/publican -v
sudo apt-get update
sudo apt-get install --only-upgrade publican
if [ -e $HOME/.publicancreators.cfg ]
then
    echo "Do nothing"
else
    cp ../lib/PublicanCreators/.publicancreators.cfg $HOME
    if [ -e /usr/bin/gedit ]
    then
        EDITOR = "gedit"
    elif [ -e /usr/bin/kate ]
    then
        EDITOR = "kate"
    elif [ -e /usr/bin/mousepad ]
    then
        EDITOR = "mousepad"
    elif [ -e /usr/bin/geany ]
    then
        EDITOR = "geany"
    elif [ -e /usr/bin/jedit ]
    then
        EDITOR = "jedit"
    fi
    $EDITOR $HOME/.publicancreators
fi
# Do any other automated setup that you need to do here
