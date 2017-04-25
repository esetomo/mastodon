# coding: utf-8
set :output, 'log/cron.log'
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 8.hours, at: '0:12' do
  rake 'mastodon:daily mastodon:media:remove_remote'
end
