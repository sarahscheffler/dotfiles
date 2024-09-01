# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Comment out default color stuff
#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
#
# .bashrc

# Source global definitions
# (Replaced by just copy pasting the ubuntu /etc/skel/.bashrc here instead)
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

######## Changes to PATH ########
# Changes in PATH have been moved to ~/.profile
. $HOME/.profile

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

######## Colored command line based on hostname/username ########
# RESET sets 0m, which resets the changes so far
RESET='\[$(tput sgr0)\]'
# 1 is bold
# 38;5 means next input sets foreground color
# \e is escape character, ake \033
export PS1="\n[ \[\e[1;38;5;$(whoami | sum | awk '{print ($1 % 256)}')m\]\u${RESET}\[\e[1m\]@\[\e[38;5;$(hostname | sum | awk '{print ($1 % 256)}')m\]\h${RESET}\[\e[1m\]:\[\e[38;5;$(pwd | sum | awk '{print ($1 % 255)}')m\]\w${RESET} ]\\$ "

#export GTK2_RC_FILES="$HOME/.config/gtk-3.0/settings.ini"
#export GTK_THEME=Adwaita:dark

######## Changed/additional commands ########
alias od="od -A x -t x1"
alias src="source $HOME/.bashrc"
alias ls="ls -CF --color"

if [[ -f "$HOME/Pictures/GraveArtoriasFinalWP.png" ]]
then
    alias swaylock="swaylock -i $HOME/Pictures/GraveArtoriasFinalWP.png"
fi


if [[ -d "$HOME/Downloads" ]]
then
    alias down="echo '$HOME/Downloads/$(ls -t  $HOME/Downloads | head -n 1)'"
fi


# Location setting
#CURRLOC=/tmp/sscheff.currloc.txt
#touch ${CURRLOC}
#setloc() {
    #echo $(pwd) > ${CURRLOC}
#}
#cdloc() {
    #cd $(cat ${CURRLOC})
#}
#cdloc # move to CURRLOC on terminal open

######## PulseAudio stuff ########
# Help from https://unix.stackexchange.com/questions/132230/read-out-pulseaudio-volume-from-commandline-i-want-pactl-get-sink-volume#164740
getdefaultsinkname() {
    pacmd stat | awk -F": " '/^Default sink name: /{printf $2}'
}
getdefaultsinkvol() {
    pacmd list-sinks | awk '/^\s+name: /{indefault = $2 == "<'$(getdefaultsinkname)'>"} 
                            /^\s+volume: / && indefault {printf $5; exit}'
}
getdefaultsinkmute() {
    pacmd list-sinks | awk '/^\s+name: /{indefault = $2 == "<'$(getdefaultsinkname)'>"} 
                            /^\s+muted: / && indefault {printf $2; exit}'
}

