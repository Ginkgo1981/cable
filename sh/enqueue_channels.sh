#!/bin/bash
echo "enqueue_channels begin"
cur_time=`date +%Y-%m-%d_%T`
cd /home/deploy/apps/crawler/current && rake channel:enqueue_channels > /mnt/logs/enqueue_channels.log 2>&1
echo "enqueue_channels finished"
#end