# Copy all files in FILES from ~ to BACKUP, then create symlinks
# from the home directory to these files

DOTFILES=~/dotfiles
BACKUP=~/backup_dotfiles
FILES="bashrc vimrc tmux.conf"

mkdir -p $BACKUP # if backup folder doesn't exist, make it

cd $DOTFILES
for file in $FILES; do
    mv ~/.$file $BACKUP
    ln -sfv $DOTFILES/.$file ~/.$file
done

