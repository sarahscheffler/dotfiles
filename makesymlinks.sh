# Copy all files in FILES from $HOME to BACKUP, then create symlinks
# from the home directory to these files

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

# Symlink neovim config file to correct location
if [ -f "$HOME/.config/nvim/init.vim" ] ; then
	mv "$HOME/.config/nvim/init.vim" "$BACKUP"
fi
ln -sfv "$DOTFILES/nvimconfig.vim" "$HOME/.config/nvim/init.vim"

# Symlink colors file to correct location
mkdir -p "$VIMCOLORS" #make vimcolors directory if dne
ln -sfv "$DOTFILES/molokai.vim" "$VIMCOLORS/molokai.vim"

# Reload configs
source $HOME/.bashrc
tmux source-file $HOME/.tmux.conf

