# Copy all files in FILES from $HOME to BACKUP, then create symlinks
# from the home directory to these files

DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
FILES="bashrc vimrc tmux.conf"

VIMCOLORS=$HOME/.vim/colors
COLORSCHEME=https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

mkdir -p $BACKUP # if backup folder doesn't exist, make it

# Move old dotfiles to backup directory and symlink these ones to $HOME
cd $DOTFILES
for file in $FILES; do
    if [ -f "$HOME/.$file" ] ; then
        mv "$HOME/.$file" "$BACKUP"
    fi
    ln -sfv "$DOTFILES/.$file" "$HOME/.$file"
done

# Download molokai color scheme for vim if we don't already have it
mkdir -p "$VIMCOLORS"
#TODO this gets the html page, not the actual raw!!!
[ -f "$VIMCOLORS/${COLORSCHEME##*/}" ] || wget "$COLORSCHEME" -P "$VIMCOLORS"

# Reload configs
source $HOME/.bashrc
tmux source-file $HOME/.tmux.conf

