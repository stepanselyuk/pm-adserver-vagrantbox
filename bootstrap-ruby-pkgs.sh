#!/usr/bin/env bash

cd ~/install

# Applying ruby PATH
source /usr/local/rvm/scripts/rvm

# required for default application config
ln -s -f $(which ruby) /usr/bin/ruby
ln -s -f $(which gem) /usr/bin/gem

# ruby gems update
$(which gem) update --system

# install compass
$(which gem) install compass

# required for default application config
ln -s -f $(which compass) /usr/local/bin/compass

# install bundler
$(which gem) install bundler