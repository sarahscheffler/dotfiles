#colored command line based on hostname/username
export PS1="\[\033[38;5;$(whoami | sum | awk '{print 1 + ($1 % 255)}')m\]\u\[$(tput sgr0)\]\[\033[38;5;m\]@\[$(tput sgr0)\]\[\033[38;5;$(hostname | sum | awk '{print 1 + ($1 % 255)}')m\]\h\[$(tput sgr0)\]\[\033[38;5;230m\]:\[$(tput sgr0)\]\[\033[38;5;$(pwd | sum | awk '{print 1 + ($1 % 255)}')m\]\w\[$(tput sgr0)\]\[\033[38;5;230m\]\$\[$(tput sgr0)\] "

# Homebrew if we're on Mac OS
if [ "$(uname)" == "Darwin" ]; then
    PATH=/usr/local/Cellar/:$PATH
fi

# better octal dump
alias od="od -A x -t x1"

# ls always lists folders wtih / and execs with *, and shows hidden files
alias ls="ls -CF"

# tmux assumes 256 color support, and reload source file to account for
# background processes to finish
alias tmux="tmux -2"

# Use vim for sudoedit (and others)
export VISUAL=vim
export EDITOR="$VISUAL"

# git gud maps to git --help
git() { if [[ $@ == "gud" || $@ == "--gud" ]]; then command git --help; else command git "$@"; fi; }         

# If we have cargo/rust, add it to path
if [ -d "$HOME/.cargo" ]; then
    PATH=$HOME/.cargo/bin:$PATH
fi


