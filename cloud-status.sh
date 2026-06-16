#!/usr/bin/env bash

if mountpoint -q ~/cloud; then
    echo '{"text":"☁","tooltip":"Phone storage mounted"}'
else 
    echo '{"text":"","tooltip":"Phone not mounted"}'
fi 
