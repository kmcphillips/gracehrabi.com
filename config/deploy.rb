require "bundler/capistrano"
require "rvm/capistrano"

set :stages, %w(production staging)
set :default_stage, "production"
require 'capistrano/ext/multistage'

set :application, "Grace Hrabi"
set :repository,  "git://github.com/kmcphillips/gracehrabi.com.git"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 5
set :rails_env, 'production'

default_run_options[:pty] = true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update", "deploy:cleanup"

after "deploy:finalize_update", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/attachments #{release_path}/public/attachments"

  %w{database.yml mail.yml facebook.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end
