#!/bin/bash
# Install apt packages listed in a packages file.
# Usage: setup_apt.sh [packages_file]   (defaults to core/apt/packages.txt)
DOTFILES=$HOME/dotfiles
PACKAGES_FILE="${1:-$DOTFILES/core/apt/packages.txt}"

if ! command -v apt-get &> /dev/null; then
    echo "Warning: apt-get not found — skipping apt package install." >&2
    exit 0
fi

if [ ! -f "$PACKAGES_FILE" ]; then
    echo "Error: packages file '$PACKAGES_FILE' not found." >&2
    exit 1
fi

# Strip comments and whitespace, drop blank lines
mapfile -t packages < <(sed 's/#.*//; s/^[[:space:]]*//; s/[[:space:]]*$//' "$PACKAGES_FILE" | grep -v '^$')

if [ ${#packages[@]} -eq 0 ]; then
    echo "No apt packages enabled in $PACKAGES_FILE."
    exit 0
fi

# Only accept valid Debian package names so a line can't be read as an apt option
for pkg in "${packages[@]}"; do
    if [[ ! "$pkg" =~ ^[a-z0-9][a-z0-9+.-]+$ ]]; then
        echo "Error: invalid package name '$pkg' in $PACKAGES_FILE — aborting." >&2
        exit 1
    fi
done

# Note: -y also accepts any package removals apt proposes to resolve conflicts
sudo apt-get update
sudo apt-get install -y -- "${packages[@]}"
