#!/bin/bash
# UDE Shader Cache Cleaner
CACHE_DIR="$HOME/.local/share/Steam/steamapps/shadercache"

# Delete caches for uninstalled games
find "$CACHE_DIR" -mindepth 1 -maxdepth 1 -type d | while read dir; do
  APPID=$(basename "$dir")
  if [ ! -d "$HOME/.local/share/Steam/steamapps/common/$(grep -l "appid\"\s*\"$APPID\"" "$HOME/.local/share/Steam/steamapps/appmanifest_*.acf)" ]; then
    rm -rf "$dir"
  fi
done

echo "[UDE] Shader cache cleaned"
