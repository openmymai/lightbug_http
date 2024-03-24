#!/bin/bash

# Extract username from the $HOME variable
username=$(basename $HOME)

set -a
source .mojoenv
set +a

# Install the modular package
curl https://get.modular.com | sudo -u $username MODULAR_AUTH=$MOJO_AUTH bash -

# Install the mojo package
sudo -u $username modular auth $MOJO_AUTH
sudo -u $username modular install mojo

export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

rm -rf ./src
git clone -b feature/builder https://github.com/thatstoasty/lightbug_http.git ./src
cd src
mojo bench.mojo