#!/usr/bin/env bash

cd ~/install

# https://nodejs.org/dist/v6.9.1/node-v6.9.1.tar.gz
NODEJS_VERSION='v6.9.1'

wget -q https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz
tar zxf node-${NODEJS_VERSION}.tar.gz
cd node-${NODEJS_VERSION}.tar.gz

./configure
make
make install

echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# set log level for all users
npm config set loglevel info --global

######################## GLOBAL PACKAGES ##########################

# install bower
npm install -g bower

# install autoprefixer & cli mode
npm install -g postcss-cli autoprefixer

# install Gulp.js and plugins
# npm install -g gulp gulp-html-tag-include gulp-less gulp-watch gulp-autoprefixer

# install Less package and plugins
npm install -g less less-plugin-autoprefix

# See also:
# https://stackoverflow.com/questions/6237295/how-can-i-update-node-js-and-npm-to-the-next-versions
# http://davidwalsh.name/upgrade-nodejs

# How to install Node.js on sandboxes:
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server

cp /vagrant/bin/autoprefixer /usr/local/bin/
chmod a+x /usr/local/bin/autoprefixer