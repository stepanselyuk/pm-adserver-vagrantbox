#!/usr/bin/env bash

cd ~/install

# see http://nsq.io/deployment/installing.html
# https://s3.amazonaws.com/bitly-downloads/nsq/nsq-0.3.8.linux-amd64.go1.6.2.tar.gz
NSQFILE="nsq-0.3.8.linux-amd64.go1.6.2"

# download NSQ binary for linux
wget -q https://s3.amazonaws.com/bitly-downloads/nsq/${NSQFILE}.tar.gz

# unpacking
tar zxvf ${NSQFILE}.tar.gz

# copy binaries to the system
cp -v ${NSQFILE}/bin/* /usr/local/bin

# directory for nsq data
mkdir -p /var/nsq

# NSQ MQ
nohup /usr/local/bin/nsqlookupd >/dev/null 2>&1 &
nohup /usr/local/bin/nsqd --data-path=/var/nsq --lookupd-tcp-address=127.0.0.1:4160 >/dev/null 2>&1 &
nohup /usr/local/bin/nsqadmin --lookupd-http-address=127.0.0.1:4161 >/dev/null 2>&1 &

# NSQ Dump messages (for testing only)
# nsq_to_file --topic=test --output-dir=/tmp --lookupd-http-address=127.0.0.1:4161