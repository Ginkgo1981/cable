

redis-cli -h loop

zcount crawler:link_queue -inf +inf


bundle exec rake channel:enqueue_channels > /mnt/logs/enqueue_channels.log 2>&1
bundle exec rake channel:enqueue_links > /mnt/logs/enqueue_links.log 2>&1
bundle exec rake channel:fetch_and_enqueue_company_job_json > /mnt/logs/fetch_and_enqueue_company_job_json.log 2>&1


bundle exec rake channel:index_to_elasticsearch > /mnt/logs/index_to_elasticsearch.log 2>&1



redis-cli KEYS crawler* | xargs redis-cli DEL
