#!/bin/bash
# Add Microsoft's apt repo for VS Code (package: code).
# Latest instructions: https://code.visualstudio.com/docs/setup/linux
set -e

sudo apt-get install -y ca-certificates curl gpg

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > "$tmpdir/microsoft.gpg"
sudo install -D -o root -g root -m 644 "$tmpdir/microsoft.gpg" /usr/share/keyrings/microsoft.gpg

sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
