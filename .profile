######## Changes to PATH ########

PATH="$HOME/.local/bin:$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"

# If we have snap, add it to path
[ -d "/var/lib/snapd/snap/bin" ] && PATH="/var/lib/snapd/snap/bin:$PATH"

### Rust
# If we have cargo/rust, add it to path
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
# Source cargo tools if we hve them
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# Set RUST_SRC_PATH
[ -d "/usr/local/bin/rustc" ] && RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Add Zotero
[ -d "/opt/Zotero_linux-x86_64" ] && PATH="/opt/Zotero_linux-x86_64:$PATH"

# Add CLion
[ -d "$HOME/Software/clion-2019.3.2bin" ] && PATH="$HOME/Software/clion-2019.3.2/bin:$PATH"

# Add TeXLive
[ -d "/usr/local/texlive/2025/bin/x86_64-linux" ] && PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

# Add ZoKrates
[ -d "/home/sscheffl/.zokrates/bin" ] && PATH="$PATH:/home/sscheffl/.zokrates/bin"

# Add SP1
[ -d "$HOME/.sp1/bin" ] && PATH="$PATH:$HOME/.sp1/bin"

# Add Go
[ -d "/usr/local/go/bin" ] && PATH="$PATH:/usr/local/go/bin"

export PATH