#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
VSCODE=$HOME/.config/Code/User
mkdir -p "$BACKUP" "$VSCODE"


for file in settings.json keybindings.json sscheffl.code-profile; do

    # Check if file is missing
    [ -f "$DOTFILES/optional/vscode/$file" ] || { echo "Source missing: $file"; continue; }

    # Backup old file
    [ -f "$VSCODE/$file" ] && mv "$VSCODE/$file" "$BACKUP"

    # Link new file
    ln -sfv "$DOTFILES/optional/vscode/$file" "$VSCODE/$file"
done

