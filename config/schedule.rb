set :output, 'log/cron.log'

every :day do
  rake 'mastodon:daily'
end
