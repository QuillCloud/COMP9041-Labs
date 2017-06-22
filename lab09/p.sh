#!/bin/sh

host_address=`host $REMOTE_ADDR 2>&1|grep Name|sed 's/.*: *//'`
echo "$host_address"