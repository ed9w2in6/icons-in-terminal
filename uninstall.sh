#!/usr/bin/env bash

DATA="${XDG_DATA_HOME:-${HOME}/.local/share}/icons-in-terminal/"

set -xe

rm -f ~/.config/fontconfig/conf.d/30-icons.conf
rm -f ~/.fonts/icons-in-terminal.ttf
rm -rf "$DATA"

fc-cache -fvr --really-force > /dev/null

set +xe

echo "icons-in-terminal uninstalled. Close all your terminal windows."
echo "You may need to restart your application or OS for them to take effect."
echo "You may also need to manually uninstall fonts and extra meta data depending on your OS."
echo "e.g. for macOS you will have to open the Font Book app and uninstall the"
echo "icons-in-terminal font."
