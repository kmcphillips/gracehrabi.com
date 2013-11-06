set :deploy_to, "/home/kevin/gracehrabi.com"

role :web, "198.211.110.159"
role :app, "198.211.110.159"
role :db,  "198.211.110.159", :primary => true
