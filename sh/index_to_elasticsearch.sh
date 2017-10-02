#!/bin/bash
echo "index begin"
cur_time=`date +%Y-%m-%d_%T`
cd /home/deploy/apps/cable/current && rake channel:index_to_elasticsearch > /mnt/logs/index_to_elasticsearch.log 2>&1
echo "index finished"
#end