#!/bin/bash
# UDE Full Installation

echo "Installing Ultimate Deck Experience..."

# 1. Core files
sudo mkdir -p /etc/ude /usr/local/share/ude
sudo cp -r modules/* /usr/local/bin/
sudo cp etc/ude.conf /etc/ude/

# 2. UI Plugin
mkdir -p ~/.local/share/Steam/steamui/plugins/ude
cp steamui/plugins/ude/* ~/.local/share/Steam/steamui/plugins/ude/

# 3. Docs
mkdir -p ~/Documents/UDE
cp -r docs/* ~/Documents/UDE/

echo "Success! Restart Steam for UI changes."
