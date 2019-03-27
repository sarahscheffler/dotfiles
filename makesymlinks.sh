# Copy all files in FILES from $HOME to BACKUP, then create symlinks
# from the home directory to these files

CONFIG=$HOME/.config
SWAY=$CONFIG/sway
NVIM=$CONFIG/nvim
DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
FILES="bashrc vimrc tmux.conf"

VIMCOLORS=$HOME/.vim/colors
# Colorscheme originally from here:
# COLORSCHEME=https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

mkdir -p $BACKUP # if backup folder doesn't exist, make it

# Move old dotfiles to backup directory and symlink these ones to $HOME
cd $DOTFILES
for file in $FILES; do
    if [ -f "$HOME/.$file" ] ; then
        mv "$HOME/.$file" "$BACKUP"
    fi
    ln -sfv "$DOTFILES/.$file" "$HOME/.$file"
done

# make config dir if DNE
mkdir -p $CONFIG

# Symlink neovim config file to correct location
mkdir -p $NVIM
[ -f "$NVIM/init.vim" ] && mv "$NVIM/init.vim" "$BACKUP"
ln -sfv "$DOTFILES/nvimconfig.vim" "$NVIM/init.vim"
# Symlink colors file to correct location
mkdir -p "$VIMCOLORS" #make vimcolors directory if dne
ln -sfv "$DOTFILES/molokai.vim" "$VIMCOLORS/molokai.vim"

# Sway stuff
mkdir -p $SWAY
[ -f "$SWAY/config" ] && mv "$SWAY/config" "$BACKUP/sway_config"
ln -sfv "$DOTFILES/sway_config" "$SWAY/config"
[ -f "$SWAY/status.sh" ] && mv "$SWAY/status.sh" "$BACKUP/sway_status.sh"
ln -sfv "$DOTFILES/sway_status.sh" "$SWAY/status.sh"

# Reload configs
source $HOME/.bashrc
tmux source-file $HOME/.tmux.conf

