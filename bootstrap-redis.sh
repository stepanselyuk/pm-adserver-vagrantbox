#!/usr/bin/env bash

# install Redis 3.x from remi
yum -y --enablerepo=remi,remi-php55 install redis php55-php-pecl-redis

# Enable Redis service to start on boot:
systemctl start redis.service
systemctl enable redis.service

# Check if Redis is Running:
systemctl status redis.service

# test ping-pong
redis-cli ping

# check http port
ss -nlp|grep redis

# benchmark of Redis
redis-benchmark -q -n 1000 -c 10 -P 5

# clean after benchmark
redis-cli flushall

# see configs:
#
# /etc/redis.conf
# /etc/redis-sentinel.conf