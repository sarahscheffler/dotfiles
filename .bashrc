#colored command line
export PS1="\[\033[38;5;123m\]\u\[$(tput sgr0)\]\[\033[38;5;230m\]@\[$(tput sgr0)\]\[\033[38;5;222m\]\h\[$(tput sgr0)\]\[\033[38;5;230m\]:\[$(tput sgr0)\]\[\033[38;5;194m\]\w\[$(tput sgr0)\]\[\033[38;5;230m\]\$\[$(tput sgr0)\] "

# Homebrew if we're on Mac OS
if [ "$(uname)" == "Darwin" ]; then
    PATH=/usr/local/Cellar/:$PATH
fi

# better octal dump
alias od="od -A x -t x1"

# ls always lists folders wtih / and execs with *
alias ls="ls -CF"

# git gud maps to git --help
git() { if [[ $@ == "gud" || $@ == "--gud" ]]; then command git --help; else command git "$@"; fi; }         

