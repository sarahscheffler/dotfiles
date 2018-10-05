#colored command line based on hostname/username
export PS1="\[\033[38;5;$(whoami | sum | awk '{print 1 + ($1 % 255)}')m\]\u\[$(tput sgr0)\]\[\033[38;5;m\]@\[$(tput sgr0)\]\[\033[38;5;$(hostname | sum | awk '{print 1 + ($1 % 255)}')m\]\h\[$(tput sgr0)\]\[\033[38;5;230m\]:\[$(tput sgr0)\]\[\033[38;5;$(pwd | sum | awk '{print 1 + ($1 % 255)}')m\]\w\[$(tput sgr0)\]\[\033[38;5;230m\]\$\[$(tput sgr0)\] "
#export PS1="\[\033[38;5;$(whoami | sum | awk '{print 1 + ($1 % 255)}')m\]\u\[$(tput sgr0)\]\[\033[38;5;m\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;$(hostname | sum | awk '{print 1 + ($1 % 255)}')m\]\h\[$(tput sgr0)\]\[\033[38;5;230m\]:\[$(tput sgr0)\]\[\033[38;5;$(pwd | sum | awk '{print 1 + ($1 % 255)}')m\]\w\[$(tput sgr0)\]\[\033[38;5;230m\]\$\[$(tput sgr0)\] "

# Homebrew if we're on Mac OS
if [ "$(uname)" == "Darwin" ]; then
    PATH=/usr/local/Cellar/:$PATH
fi

# Add /usr/local/bin to $PATH
PATH=/usr/local/bin:$PATH

# if it exists, add /Library/TeX/texbin to PATH
if [ -d "/Library/TeX" ]; then
    PATH=/Library/TeX/texbin:$PATH
fi

# better octal dump
alias od="od -A x -t x1"

# src to source ~/.bashrc
alias src="source $HOME/.bashrc"

# make vim nvim
if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
fi

# ls always lists folders wtih / and execs with *, and shows hidden files
alias ls="ls -CF"

# tmux assumes 256 color support, and reload source file to account for
# background processes to finish
alias tmux="tmux -2"

# in tmux, panes with ssh include the hostname in their name
ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "ssh:$(echo $* | rev | cut -d ' ' -f1 | rev | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

# Use vim for sudoedit (and others)
export VISUAL=vim
export EDITOR="$VISUAL"

# Use emacs keys in the terminal
set -o emacs

# git gud maps to git --help
git() { if [[ $@ == "gud" || $@ == "--gud" ]]; then command git --help; else command git "$@"; fi; }         

# If we have cargo/rust, add it to path
if [ -d "$HOME/.cargo" ]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

# If we have Rust, set RUST_SRC_PATH
if [ -x /usr/local/bin/rustc ]; then
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

# If Skim exists where we expect it, alias skimpdf tool
if [ -x /Applications/Skim.app/Contents/SharedSupport/skimpdf ]; then
    alias skimpdf="/Applications/Skim.app/Contents/SharedSupport/skimpdf"
fi
