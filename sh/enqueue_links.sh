#!/bin/bash
echo "enqueue_links begin"
cur_time=`date +%Y-%m-%d_%T`
cd /home/deploy/apps/crawler/current && rake channel:enqueue_links > /mnt/logs/enqueue_links.log 2>&1
echo "enqueue_links finished"
#end