#colored command line
export PS1="\[\033[38;5;123m\]\u\[$(tput sgr0)\]\[\033[38;5;230m\]@\[$(tput sgr0)\]\[\033[38;5;222m\]\h\[$(tput sgr0)\]\[\033[38;5;230m\]:\[$(tput sgr0)\]\[\033[38;5;194m\]\w\[$(tput sgr0)\]\[\033[38;5;230m\]\$\[$(tput sgr0)\] "

# Homebrew
PATH=/usr/local/Cellar/:$PATH

# git gud maps to git --help
git() { if [[ $@ == "gud" || $@ == "--gud" ]]; then command git --help; else command git "$@"; fi; }         

# TEMPORARY JAVASCRIPT THING
PATH=/Users/firechant/Projects/Chrome-XSS-Vulnerability/spoon-master/node_modules/.bin:$PATH

