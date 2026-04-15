#!/bin/bash
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
NVIM=$HOME/.config/nvim
mkdir -p "$BACKUP" "$NVIM"

[ -f "$NVIM/init.vim" ] && mv "$NVIM/init.vim" "$BACKUP"
ln -sfv "$DOTFILES/core/neovim/vimplugconfig.vim" "$NVIM/vimplugconfig.vim"
