#!/bin/bash
# Add Synaptics' apt repo for DisplayLink (package: displaylink-driver).
# Latest instructions: https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu
# Note: this installs Synaptics' keyring .deb as root, which then adds the repo.
set -e

sudo apt-get install -y ca-certificates curl

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT
curl -fsSL -o "$tmpdir/synaptics-repository-keyring.deb" \
    https://www.synaptics.com/sites/default/files/Ubuntu/pool/stable/main/all/synaptics-repository-keyring.deb
sudo apt-get install -y "$tmpdir/synaptics-repository-keyring.deb"
