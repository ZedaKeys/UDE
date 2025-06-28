#!/bin/bash
# UDE Save Backup System
BACKUP_DIR="$HOME/UDE_backups/$(date +%Y%m%d_%H%M%S)"

mkdir -p "$BACKUP_DIR"
rsync -av \
  "$HOME/.local/share/Steam/steamapps/compatdata/" \
  "$HOME/.steam/steam/userdata/" \
  "$BACKUP_DIR"

echo "[UDE] Backed up saves to: $BACKUP_DIR"
