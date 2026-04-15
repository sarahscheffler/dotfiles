#!/bin/bash
# Set up dotfiles by running each program's setup script.
# core/ programs are always installed.
# optional/ programs are installed only if listed (uncommented) in optional/enabled.

DOTFILES=$HOME/dotfiles
BACKUP=$HOME/backup_dotfiles
mkdir -p "$BACKUP"

# sh must run first so ~/.path exists before any other setup scripts run
echo "Setting up sh..."
bash "$DOTFILES/core/sh/setup_sh.sh"

# Install remaining core programs
for dir in "$DOTFILES"/core/*/; do
    [ "$(basename "$dir")" = "sh" ] && continue
    script="$dir/setup_$(basename "$dir").sh"
    if [ -x "$script" ]; then
        echo "Setting up $(basename "$dir")..."
        bash "$script"
    fi
done

# Install optional programs based on optional/enabled list.
# - Uncommented lines are installed.
# - Lines referencing a missing folder are warned about and removed.
# - Folders with no entry in the list are added as disabled (commented).
ENABLED_FILE="$DOTFILES/optional/enabled"
touch "$ENABLED_FILE"
tmpfile=$(mktemp) || { echo "Error: failed to create temp file." >&2; exit 1; }
trap 'rm -f "$tmpfile"' EXIT
mentioned=()

while IFS= read -r line || [ -n "$line" ]; do
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
        prog=$(echo "$line" | sed 's/^[[:space:]]*#//')
        [ -d "$DOTFILES/optional/$prog" ] && mentioned+=("$prog")
        echo "$line" >> "$tmpfile"
        continue
    fi
    prog="$line"
    mentioned+=("$prog")
    if [ ! -d "$DOTFILES/optional/$prog" ]; then
        echo "Warning: optional program '$prog' not found in optional/ — removing from list." >&2
        continue
    fi
    echo "$line" >> "$tmpfile"
    script="$DOTFILES/optional/$prog/setup_$prog.sh"
    if [ -x "$script" ]; then
        echo "Setting up optional: $prog..."
        bash "$script"
    fi
done < "$ENABLED_FILE"

for dir in "$DOTFILES"/optional/*/; do
    [ -d "$dir" ] || continue
    prog=$(basename "$dir")
    if [[ ! " ${mentioned[*]} " =~ " $prog " ]]; then
        echo "Note: '$prog' found in optional/ but missing from enabled list — adding as disabled."
        echo "#$prog" >> "$tmpfile"
    fi
done

trap - EXIT
mv "$tmpfile" "$ENABLED_FILE"

######## Activation ########
# Reload tmux config if a session is running
tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true

# Source bashrc to apply changes to current shell
source "$HOME/.bashrc"
