# frozen_string_literal: true

lock '3.8.1'

set :repo_url, ENV.fetch('REPO', 'https://github.com/tootsuite/mastodon.git')
set :branch, ENV.fetch('BRANCH', 'master')

set :application, 'mastodon'
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :migration_role, :app

append :linked_files, '.env.production', 'public/robots.txt'
append :linked_dirs, 'vendor/bundle', 'node_modules', 'public/system', 'public/packs'

namespace :deploy do
  after :updated, "assets:precompile"
end

namespace :assets do
  task :precompile do
    on roles(:web) do
      rsync_host = host
      run_locally do
        execute "RAILS_ENV=#{fetch(:rails_env)} rake assets:precompile"
        execute "rsync -av --delete public/assets/ #{rsync_host.user}@#{rsync_host.hostname}:#{shared_path}/public/assets/"
        execute "rsync -av --delete public/packs/ #{rsync_host.user}@#{rsync_host.hostname}:#{shared_path}/public/packs/"
      end
    end
  end
end
