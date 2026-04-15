SEPARATOR=' | '
SPEAKERS='alsa_output.pci-0000_00_1f.3.analog-stereo'
KNIFEROSE='bluez_sink.2C_41_A1_03_CF_C7.a2dp_sink'

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

sink_command() {
if [[ $(getdefaultsinkname | grep ${SPEAKERS}) ]];
    then echo -n '(speakers)';
    else if [[ $(getdefaultsinkname | grep ${KNIFEROSE}) ]];
        then echo -n '(kniferose)';
        else echo -n '(?)'; 
    fi; 
fi
}
mute_command() {
    [[ $(getdefaultsinkmute | grep 'yes')  ]] && echo -n '(MUTE) '
}

brightness_command() {
    echo -n "Bri: $(( 100 * $(brightnessctl g) / $(brightnessctl m) ))%"
}
volume_command() {
    echo -n "Vol: $(getdefaultsinkvol) $(mute_command)$(sink_command)"
}
date_command() {
    date +'%Y-%m-%d  %A  %H:%M:%S '
}
wifi_command() {
    nmcli -c no -f TYPE,NAME c | awk 'NR>1{printf "%s: %s", $1, $2; exit}'
}
battery_command() {
    echo -n "Bat: "; upower -i $(upower -e | grep 'BAT') | \
        awk '/^\s+time to empty: / {hrs1=$4; hrs2=$5};
            /^\s+percentage: / {perc=$2; printf "%s (%s %s)", perc, hrs1, hrs2; exit}'
}

echo -n "$(wifi_command) ${SEPARATOR} $(battery_command) ${SEPARATOR} $(brightness_command) ${SEPARATOR} $(volume_command) ${SEPARATOR} $(date_command)"
