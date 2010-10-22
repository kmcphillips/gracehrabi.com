namespace :import do

  desc "Import all data from legacy PHP site"
  task :all => :environment do
    ## Include some stuff that will help us
    include ActionView::Helpers::SanitizeHelper

    ## Load the config file
    config = File.open("#{Rails.root}/config/database.yml", "r") do |f|
      YAML::load(f).try(:[], "legacy")
    end
    raise "Key 'legacy' was not found in config/database.yml" unless config

    ## Connect to the database
    db = Mysql2::Client.new(:host => config["host"], :username => config["username"], :password => config["password"], :database => config["schema"])


  end
end

