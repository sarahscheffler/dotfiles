#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
mkdir -p "$BACKUP"

[ -f "$HOME/.tmux.conf" ] && mv "$HOME/.tmux.conf" "$BACKUP"
ln -sfv "$DOTFILES/core/tmux/tmux.conf" "$HOME/.tmux.conf"

tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
