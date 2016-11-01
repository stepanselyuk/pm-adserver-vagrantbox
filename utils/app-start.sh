#!/usr/bin/env bash

sudo bash << EOF

systemctl start httpd

# NSQ MQ
nohup /usr/local/bin/nsqlookupd >/dev/null 2>&1 &
nohup /usr/local/bin/nsqd --data-path=/var/nsq --lookupd-tcp-address=127.0.0.1:4160 >/dev/null 2>&1 &
nohup /usr/local/bin/nsqadmin --lookupd-http-address=127.0.0.1:4161 >/dev/null 2>&1 &

# NSQ Dump messages (for testing only)
# nsq_to_file --topic=test --output-dir=/tmp --lookupd-http-address=127.0.0.1:4161

EOF