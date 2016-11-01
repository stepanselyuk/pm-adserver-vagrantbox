#!/usr/bin/env bash

PROJECTDIR="/var/www/vhosts"

# create dir if not exist
mkdir -p ${PROJECTDIR}

# copy config for httpd
cp -f /vagrant/conf/httpd/vhost-symfony-backend.conf /etc/httpd/conf.d/

# for httpd logs
mkdir -p ${PROJECTDIR}/logs/symfony-backend

# add line to /etc/hosts
echo "127.0.0.1     adserver.dev www.adserver.dev" >> /etc/hosts

# restart httpd
systemctl restart httpd
