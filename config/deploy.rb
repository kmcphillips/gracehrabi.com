set :application, "Grace Hrabi"
set :repository,  "git://github.com/kimos/gracehrabi.com.git"
set :deploy_to, "/home/kevin/gracehrabi.com"
set :user, "kevin"
set :use_sudo, false
set :scm, "git"
set :keep_releases, 10

default_run_options[:pty] = true

role :web, "gracehrabi.com"
role :app, "gracehrabi.com"
role :db,  "gracehrabi.com", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy", "symlink_shared_files"

task :symlink_shared_files do
  run "ln -s #{shared_path}/images #{release_path}/public/images/attachment"

  %w{database.yml}.each do |config|
    run "ln -s #{shared_path}/#{config} #{release_path}/config/#{config}"
  end
end
