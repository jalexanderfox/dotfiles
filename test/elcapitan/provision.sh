#!/bin/bash
set -e

# NOTE: this adds the user.name to the current user
# Vagrant file has "privileged: false" for provisioner
# so that vagrant user runs this and not root
# NOTE: we want this regardless, since our real use case
# is with a non-root user.

cd; git clone https://github.com/jalexanderfox/dotfiles.git && mv dotfiles ~/.dotfiles
cd ~/.dotfiles && ./setup_all.sh


if [[ -n "$@" ]]
  then
    echo /vagrant/install_test.sh $@ -p /vagrant/
    /vagrant/install_test.sh $@ -p /vagrant/
fi
