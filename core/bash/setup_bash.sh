#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
mkdir -p "$BACKUP"

for file in bashrc bash_profile; do
    [ -f "$HOME/.$file" ] && mv "$HOME/.$file" "$BACKUP"
    ln -sfv "$DOTFILES/core/bash/$file" "$HOME/.$file"
done

if [ ! -f "$HOME/.path" ]; then
    echo "Warning: ~/.path does not exist. PATH may not be set correctly." \
         "Run setup_sh.sh or setup.sh first, then re-source ~/.bashrc." >&2
fi
