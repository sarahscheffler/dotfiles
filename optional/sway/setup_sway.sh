#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
SWAY=$HOME/.config/sway
mkdir -p "$BACKUP" "$SWAY"

[ -f "$SWAY/config" ] && mv "$SWAY/config" "$BACKUP/sway_config"
ln -sfv "$DOTFILES/optional/sway/sway_config" "$SWAY/config"
[ -f "$SWAY/status.sh" ] && mv "$SWAY/status.sh" "$BACKUP/sway_status.sh"
ln -sfv "$DOTFILES/optional/sway/sway_status.sh" "$SWAY/status.sh"
