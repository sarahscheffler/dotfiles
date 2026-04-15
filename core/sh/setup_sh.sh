#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
mkdir -p "$BACKUP"

[ -f "$HOME/.path" ] && mv "$HOME/.path" "$BACKUP"
ln -sfv "$DOTFILES/core/sh/path" "$HOME/.path"
