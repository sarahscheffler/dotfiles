# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

######## Changes to PATH ########
# Changes in PATH have been moved to ~/.profile
. $HOME/.profile

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

######## Colored command line based on hostname/username ########
RESET='$(tput sgr0)'
export PS1="\n[ \[\033[38;5;$(whoami | sum | awk '{print ($1 % 256)}')m\]\u\[${RESET}\]@\[\033[38;5;$(hostname | sum | awk '{print ($1 % 256)}')m\]\h\[${RESET}\]:\[\033[38;5;$(pwd | sum | awk '{print ($1 % 256)}')m\]\w\[${RESET}\] ]\\$ "

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

