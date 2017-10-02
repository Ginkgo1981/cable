# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
set :output, '/mnt/logs/cron.log'

every :day, at: %w(8:45pm) do
  rake 'channel:index_to_elasticsearch'
end