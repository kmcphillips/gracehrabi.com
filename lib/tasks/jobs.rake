namespace :jobs do

  desc "Migrate all data to get rid of /assets from the file paths"
  task assets_migration: :environment do
    puts "Starting migration..."

    ActiveRecord::Base.transaction do
      # blocks
      # events
      # images
      # medias
      # posts
      # tracks
    end

    puts "Success!"
  end

end
