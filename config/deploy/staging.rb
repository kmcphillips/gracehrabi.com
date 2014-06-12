set :deploy_to, "/home/kevin/staging.gracehrabi.com"
set :rails_env, 'staging'
set :branch, 'staging'

role :web, "198.211.110.159"
role :app, "198.211.110.159"
role :db,  "198.211.110.159", :primary => true
