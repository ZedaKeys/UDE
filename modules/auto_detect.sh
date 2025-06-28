#!/bin/bash
# UDE Auto Game Detection
STEAM_APPS_DIR="$HOME/.local/share/Steam/steamapps"

detect_game() {
  APP_ID=$(pgrep -fla steam | grep -Eo "steam_app_[0-9]+" | cut -d_ -f3)
  [ -z "$APP_ID" ] && exit 0
  
  GAME_NAME=$(grep -l "appid\"\s*\"$APP_ID\"" "$STEAM_APPS_DIR"/appmanifest_*.acf | 
    xargs grep "name" | cut -d'"' -f4)
  
  echo "Detected: $GAME_NAME (AppID: $APP_ID)"
  ./performance.sh "$APP_ID"
}

detect_game
