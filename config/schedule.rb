set :output, 'log/cron.log'
job_type :rake, "$(rbenv init -); cd :path && :environment_variable=:environment bundle exec rake :task --silent :output"

#every :day do
#  rake 'mastodon:daily'
#end
