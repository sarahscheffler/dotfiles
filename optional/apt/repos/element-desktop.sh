#!/bin/bash
# Add Element's apt repo (package: element-desktop).
# Latest instructions: https://element.io/download#linux
set -e

sudo apt-get install -y ca-certificates curl

sudo curl -fsSL -o /usr/share/keyrings/element-io-archive-keyring.gpg \
    https://packages.element.io/debian/element-io-archive-keyring.gpg
sudo chmod a+r /usr/share/keyrings/element-io-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/element-io-archive-keyring.gpg] https://packages.element.io/debian/ default main" \
    | sudo tee /etc/apt/sources.list.d/element-io.list > /dev/null
