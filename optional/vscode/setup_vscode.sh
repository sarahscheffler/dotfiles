#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
VSCODE=$HOME/.config/Code/User
mkdir -p "$BACKUP" "$VSCODE"
mkdir -p "$BACKUP/profiles"
mkdir -p "$VSCODE/profiles"


for file in settings.json keybindings.json profiles/sscheffl.code-profile; do

    # Check if file is missing
    [ -f "$DOTFILES/optional/vscode/$file" ] || { echo "Source missing: $file"; continue; }

    # Backup old file
    [ -f "$VSCODE/$file" ] && mv "$VSCODE/$file" "$BACKUP"

    # Link new file
    ln -sfv "$DOTFILES/optional/vscode/$file" "$VSCODE/$file"
done

# Tell user to manually import code profile
echo "[TODO] You still need to manually import $VSCODE/profiles/sscheffl.code-profile into VSCode by doing Ctrl+Shift+P -> Profiles: Import Profile"


