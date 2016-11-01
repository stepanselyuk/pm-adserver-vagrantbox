#!/usr/bin/env bash

cd ~/install

# composer (default for the system)
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# make executable
chmod a+x /usr/local/bin/composer

# for root
ln -s /usr/local/bin/composer /usr/local/sbin/composer