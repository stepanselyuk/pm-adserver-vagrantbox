#!/usr/bin/env bash

cd ~/install

# install latest ruby
# https://unix.stackexchange.com/questions/75892/keyserver-timed-out-when-trying-to-add-a-gpg-public-key
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# fallback
gpg2 --keyserver hkp://keys.gnupg.net:80 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
# /fallback

curl -sSL https://get.rvm.io | bash -s stable --ruby
