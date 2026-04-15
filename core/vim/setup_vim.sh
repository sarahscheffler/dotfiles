#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
VIMCOLORS=$HOME/.vim/colors
mkdir -p "$BACKUP" "$VIMCOLORS"

[ -f "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$BACKUP"
ln -sfv "$DOTFILES/core/vim/vimrc" "$HOME/.vimrc"
ln -sfv "$DOTFILES/core/vim/molokai.vim" "$VIMCOLORS/molokai.vim"
