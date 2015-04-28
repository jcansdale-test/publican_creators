#!/bin/bash
echo "##################################################################################"
echo "#                  PublicanCreators Upgrader                                     #"
echo "##################################################################################"
echo "Linking binary"
FROM="$(pwd)"
sudo ln -s $FROM/console /usr/bin/publicancreators.sh

echo "Creating Desktop file"
sudo cat <<EOF > $HOME/.local/share/applications/publicancreators.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=PublicanCreators
Exec=/usr/bin/publicancreators.sh
Icon=$FROM/publican.png
EOF