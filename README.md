

redis-cli -h loop

zcount crawler:link_queue -inf +inf


bundle exec rake channel:enqueue_links > /mnt/logs/enqueue.log 2>&1
bundle exec rake channel:dequeue > /mnt/logs/dequeue.log 2>&1
rake crawler:sink > /mnt/logs/sink.log 2>&1