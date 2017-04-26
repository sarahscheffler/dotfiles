# Copy all files in FILES from ~ to BACKUP, then create symlinks
# from the home directory to these files

DOTFILES=~/dotfiles
BACKUP=~/backup_dotfiles
FILES="bashrc vimrc tmux.conf"

mkdir -p $BACKUP # if backup folder doesn't exist, make it

# Move old dotfiles to backup directory and symlink these ones to ~
cd $DOTFILES
for file in $FILES; do
    if [ -e ~/.$file ] ; then
        mv ~/.$file $BACKUP
    fi
    ln -sfv $DOTFILES/.$file ~/.$file
done

# Download molokai color scheme for vim
mkdir -p ~/.vim/colors
wget https://github.com/tomasr/molokai/blob/master/colors/molokai.vim -P ~/.vim/colors

source ~/.bashrc

