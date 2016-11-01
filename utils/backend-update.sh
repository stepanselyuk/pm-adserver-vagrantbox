#!/usr/bin/env bash

cd /var/www/vhosts/symfony-backend
git fetch origin -p
git pull
ant helper-resetall-vagrant