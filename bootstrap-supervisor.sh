#!/usr/bin/env bash

# install package
yum -y install supervisor

# make directory for extra configs
mkdir -p /etc/supervisor/conf.d

# copy main config
cp /vagrant/conf/supervisor/supervisord.conf /etc/

# copy extra configs (programs)
cp /vagrant/conf/supervisor/conf.d/* /etc/supervisor/conf.d/

# use as "sudo supervisord -n" for run in foreground
