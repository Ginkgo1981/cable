# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# set :output, '/mnt/logs/cron_index.log'
# set :job_template, nil

every 2.hours do
  command '/home/deploy/apps/sh/index_to_elasticsearch.sh'
end
