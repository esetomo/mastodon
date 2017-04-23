set :output, 'log/cron.log'

every 8.hours, at: '0:12' do
  rake 'mastodon:daily mastodon:media:remove_remote'
end
