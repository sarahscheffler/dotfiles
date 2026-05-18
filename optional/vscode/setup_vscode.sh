#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
VSCODE=$HOME/.config/Code/User
VSCODE_EXTENSIONS=$HOME/.vscode/extensions
mkdir -p "$BACKUP" "$VSCODE" "$VSCODE_EXTENSIONS"
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

# Now do the extension folder latex_vscode_custom_highlights
EXT_SRC="$DOTFILES/optional/vscode/latex_vscode_custom_highlights"
EXT_DEST="$VSCODE_EXTENSIONS/latex_vscode_custom_highlights"
if [ -d "$EXT_SRC" ]; then
    # Backup old extension folder/symlink if present
    { [ -e "$EXT_DEST" ] || [ -L "$EXT_DEST" ]; } && mv "$EXT_DEST" "$BACKUP/"
    # Link new extension folder
    ln -sfv "$EXT_SRC" "$EXT_DEST"
else
    echo "Source missing: latex_vscode_custom_highlights"
fi

# Tell user to manually import code profile
echo "You still need to manually import $VSCODE/profiles/sscheffl.code-profile into VSCode by doing Ctrl+Shift+P -> Profiles: Import Profile"


