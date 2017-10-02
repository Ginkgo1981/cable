#!/bin/bash
echo "index begin"
cur_time=`date +%Y-%m-%d_%T`
cd /home/deploy/apps/crawler/current && rake channel:fetch_and_enqueue_company_job_json > /mnt/logs/fetch_and_enqueue_company_job_json.log 2>&1
echo "index finished"
#end