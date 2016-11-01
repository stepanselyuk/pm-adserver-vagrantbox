#!/usr/bin/env bash

PROJECTDIR="/var/www/vhosts"

########### BACKEND #############

# remove all old content
rm -rf ${PROJECTDIR}/symfony-backend

# httpd logs
# case of the dir was removed by user
mkdir -p ${PROJECTDIR}/logs/symfony-backend
rm -rf ${PROJECTDIR}/logs/symfony-backend/*

cd ${PROJECTDIR}

# clone project from git
git clone git@github.com:stepanselyuk/pm-adserver-test-task.git symfony-backend
cd symfony-backend

# checkout master branch
git checkout -b master --track origin/master

# download composer
ant composer-download

if [ -z "$GITHUB_TOKEN" ]; then
    echo Please, enter your GitHub token:
    read GITHUB_TOKEN
fi

# add github token to ./auth.json
composer config github-oauth.github.com $GITHUB_TOKEN
php bin/composer config github-oauth.github.com $GITHUB_TOKEN

# init/reinit/install project
ant helper-after-merge

chmod -R 755 ./var/cache ./var/logs ./var/sessions

php bin/symfony_requirements

# create convenient symbolic link in home directory
rm -f ~/adserver
ln -fs /var/www/vhosts/symfony-backend ~/adserver

# restart httpd (need after remove logs)
sudo systemctl restart httpd

# create NSQ topics and channels
sh /vagrant/utils/nsq-reset-topics.sh