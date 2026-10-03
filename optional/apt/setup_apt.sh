#!/bin/bash
# Add any enabled third-party repos (optional/apt/repos.txt), then install
# optional apt packages (uncommented lines in optional/apt/packages.txt).
DOTFILES=$HOME/dotfiles
APT_DIR="$DOTFILES/optional/apt"

if ! command -v apt-get &> /dev/null; then
    echo "Warning: apt-get not found — skipping optional apt setup." >&2
    exit 0
fi

mapfile -t repos < <(sed 's/#.*//; s/^[[:space:]]*//; s/[[:space:]]*$//' "$APT_DIR/repos.txt" | grep -v '^$')

for repo in "${repos[@]}"; do
    script="$APT_DIR/repos/$repo.sh"
    if [[ ! "$repo" =~ ^[a-z0-9_-]+$ ]] || [ ! -f "$script" ]; then
        echo "Warning: unknown apt repo '$repo' in repos.txt — skipping." >&2
        continue
    fi
    echo "Adding apt repo: $repo..."
    bash "$script" || echo "Warning: failed to add apt repo '$repo'." >&2
done

bash "$DOTFILES/core/apt/setup_apt.sh" "$APT_DIR/packages.txt"
