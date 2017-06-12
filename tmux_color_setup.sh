TMUX_INACTIVE="colour241"
TMUX_BG="colour0"
TMUX_LIGHTTEXTCOLOR="colour231"
TMUX_DARKTEXTCOLOR="colour233"
TMUX_LIGHTCOLORS=(3 7 10 11 14 15 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 135 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 247 248 249 250 251 252 253 254 255)
# Set the "hostcolor" based on a hash of the hostname
tmux set-environment -g TMUX_HOSTCOLOR $(hostname | sum | awk '{print 1 + ($1 % 255)}')

tmux set-environment -g TMUX_INACTIVE "${TMUX_INACTIVE}"
tmux set-environment -g TMUX_BG "${TMUX_BG}"
tmux set-environment -g TMUX_LIGHTTEXTCOLOR "${TMUX_LIGHTTEXTCOLOR}"
tmux set-environment -g TMUX_DARKTEXTCOLOR "${TMUX_DARKTEXTCOLOR}"
tmux set-environment -g TMUX_ACTIVE "colour$(tmux show-environment -g TMUX_HOSTCOLOR | sed 's/^TMUX_HOSTCOLOR=//')"
tmux set-environment -g TMUX_TEXTCOLOR "${TMUX_LIGHTTEXTCOLOR}" # default

# define TMUX_TEXTCOLOR as light or dark based on TMUX_HOSTCOLOR (active color)
if [[ " ${TMUX_LIGHTCOLORS[@]} " =~ " ${TMUX_HOSTCOLOR} " ]]; then
    tmux set-environment -g TMUX_TEXTCOLOR ${TMUX_DARKTEXTCOLOR}
else 
    tmux set-environment -g TMUX_TEXTCOLOR ${TMUX_LIGHTTEXTCOLOR}
fi

# status bar colors
tmux set -g status-fg $TMUX_TEXTCOLOR
tmux set -g status-bg $TMUX_ACTIVE
tmux set -g status-attr default #TODO check this
tmux setw -g window-status-current-fg $TMUX_ACTIVE
tmux setw -g window-status-current-bg $TMUX_TEXTCOLOR
tmux setw -g window-status-current-attr bright
tmux setw -g window-status-format " #I:#W "
tmux setw -g window-status-current-format " #I:#W "
tmux setw -g window-status-fg $TMUX_TEXTCOLOR
tmux setw -g window-status-bg $TMUX_ACTIVE
tmux setw -g window-status-attr dim

tmux setw -g window-status-bell-attr bright
tmux setw -g window-status-bell-fg $TMUX_TEXTCOLOR
tmux setw -g window-status-bell-bg $TMUX_ACTIVE

# pane colors
tmux set -g pane-active-border-fg $TMUX_ACTIVE
tmux set -g pane-active-border-bg $TMUX_BG
tmux set -g pane-border-fg $TMUX_INACTIVE
tmux set -g pane-border-bg $TMUX_BG
tmux set -g display-panes-active-colour $TMUX_ACTIVE
tmux set -g display-panes-colour $TMUX_TEXTCOLOR

# mesage/command colors
tmux set -g message-fg $TMUX_TEXTCOLOR
tmux set -g message-bg $TMUX_ACTIVE
tmux set -g message-attr bright #TODO check

# mode switch colors
tmux setw -g mode-fg $TMUX_TEXTCOLOR
tmux setw -g mode-bg $TMUX_ACTIVE
tmux setw -g mode-attr default
