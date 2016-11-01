#!/usr/bin/env bash

# copy file with environment settings
cp -f /vagrant/conf/etc/environment /etc/

mkdir ~/install && cd ~/install

# EPEL
yum -y install deltarpm epel-release

# remi
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

yum repolist

# get fresh packages
yum -y update

# dev libraries
yum -y groupinstall "Development Tools"

# for virtualbox additions
yum -y install dkms binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers
yum -y install kernel-devel

# utils
yum -y install wget ntpdate htop iotop iftop mc nano libffi-devel ant tree yum-cron

# apache and mysql
yum -y install httpd mariadb mariadb-libs mariadb-server

# additional php packages
yum -y --enablerepo=remi,remi-php55 install \
php55-php \
php55-php-devel \
php55-php-mysqlnd \
php55-php-intl \
php55-php-pdo \
php55-php-mbstring \
php55-php-xml \
php55-php-bcmath \
php55-php-gd \
php55-php-gmp \
php55-php-mcrypt \
php55-php-pecl-apcu \
php55-php-pecl-geoip \
php55-php-pecl-json-post \
php55-php-pecl-oauth \
php55-php-soap \
php55-php-twig
# pear
yum -y --enablerepo=remi,remi-php55 install \
php-pear \
php-channel-* \
php55-php-pear \
php55-php-channel-*

# set php55 as default php
ln -s -f /usr/bin/php55 /usr/bin/php

export PATH=$PATH:/opt/remi/php55/root/usr/bin

# adjust some PHP options

# /etc/php.ini
PHP_INI='/opt/remi/php55/root/etc/php.ini'

SED_BEGIN='s#^;*[[:blank:]]*'
SED_MIDDLE='[[:blank:]]*=.*#'

sed -i $SED_BEGIN'date.timezone'$SED_MIDDLE'date.timezone = "UTC"#g' ${PHP_INI}
sed -i $SED_BEGIN'realpath_cache_size'$SED_MIDDLE'realpath_cache_size = 1M#g' ${PHP_INI}
sed -i $SED_BEGIN'realpath_cache_ttl'$SED_MIDDLE'realpath_cache_ttl = 120#g' ${PHP_INI}
sed -i $SED_BEGIN'max_execution_time'$SED_MIDDLE'max_execution_time = 300#g' ${PHP_INI}
sed -i $SED_BEGIN'post_max_size'$SED_MIDDLE'post_max_size = 32M#g' ${PHP_INI}
sed -i $SED_BEGIN'default_charset'$SED_MIDDLE'default_charset = "UTF-8"#g' ${PHP_INI}
sed -i $SED_BEGIN'display_errors'$SED_MIDDLE'display_errors = On#g' ${PHP_INI}
sed -i $SED_BEGIN'max_input_vars'$SED_MIDDLE'max_input_vars = 10000#g' ${PHP_INI}
sed -i $SED_BEGIN'upload_max_filesize'$SED_MIDDLE'upload_max_filesize = 32M#g' ${PHP_INI}
sed -i $SED_BEGIN'disable_functions'$SED_MIDDLE'disable_functions = #g' ${PHP_INI}
sed -i $SED_BEGIN'disable_classes'$SED_MIDDLE'disable_classes = #g' ${PHP_INI}
sed -i $SED_BEGIN'open_basedir'$SED_MIDDLE';open_basedir = #g' ${PHP_INI}
sed -i $SED_BEGIN'session.save_path'$SED_MIDDLE'session.save_path = "/tmp"#g' ${PHP_INI}
sed -i $SED_BEGIN'memory_limit'$SED_MIDDLE'memory_limit = 512M#g' ${PHP_INI}

# replace defaults /opt/remi/php55/root/var/lib/php/... to /tmp
HTTPD_PHP_CONFIG='/etc/httpd/conf.d/php55-php.conf';
sed -i 's#session.save_path[[:blank:]]*".*"#session.save_path "/tmp"#g' ${HTTPD_PHP_CONFIG}
sed -i 's#soap.wsdl_cache_dir[[:blank:]]*".*"#soap.wsdl_cache_dir "/tmp"#g' ${HTTPD_PHP_CONFIG}

systemctl enable httpd
systemctl enable mariadb
systemctl disable firewalld

# set up crontab (date & time sync)
echo "47      23      *       *       *       /usr/sbin/ntpdate -b -s 0.us.pool.ntp.org" | crontab -

# set apache user as vagrant, for get write permissions
HTTPD_CONFIG='/etc/httpd/conf/httpd.conf'
sed -i 's#^User[[:blank:]].*#User vagrant#g' ${HTTPD_CONFIG}
sed -i 's#^Group[[:blank:]].*#Group vagrant#g' ${HTTPD_CONFIG}

# chown root:vagrant /opt/remi/php55/root/var/lib/php/{session,wsdlcache}

# default document root for httpd (specified in httpd.conf)
mkdir -p /var/www/html

# restart services
systemctl restart httpd
systemctl start mariadb
systemctl stop firewalld