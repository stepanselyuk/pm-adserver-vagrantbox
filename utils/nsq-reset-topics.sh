#!/usr/bin/env bash

# create topics and channels for NSQ
function reset_topic {
    curl -X POST "http://127.0.0.1:4151/topic/delete?topic=$1"
    curl -X POST "http://127.0.0.1:4151/topic/create?topic=$1"
    curl -X POST "http://127.0.0.1:4151/channel/create?topic=$1&channel=$2"
}

# topic for delayed messages
reset_topic __socloz_delayed default

# remove old logs
sudo bash << EOF

rm -f /var/log/socloz_nsq_topic_consume__*

EOF

echo "OK"