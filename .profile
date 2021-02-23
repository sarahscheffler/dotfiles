######## Changes to PATH ########

PATH="$HOME/.local/bin:$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"

# If we have snap, add it to path
[ -d "/var/lib/snapd/snap/bin" ] && PATH="/var/lib/snapd/snap/bin:$PATH"

# If we have cargo/rust, add it to path
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# If we have Rust, set RUST_SRC_PATH
[ -d "/usr/local/bin/rustc" ] && RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# If we have Zotero, add it to path
[ -d "/opt/Zotero_linux-x86_64" ] && PATH="/opt/Zotero_linux-x86_64:$PATH"

# Add CLion
[ -d "$HOME/Software/clion-2019.3.2bin" ] && PATH="$HOME/Software/clion-2019.3.2/bin:$PATH"

# For jupyter: If we have ~/.local/bin, add it to path
#[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"

export PATH

