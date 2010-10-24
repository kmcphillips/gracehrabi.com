begin
  ActiveRecord::Base.transaction do
    puts "Deleting all Blocks"
    Block.destroy_all
    puts "Creating blocks"

    {"contact" => "/contact", "bio" => "/bio"}.each_pair do |k, v|
      b = Block.new :body => ""
      b.label = k
      b.path = v
      b.accepts_image = true if k = "contact"
      b.save!
    end

    if Rails.env.development?
      puts "Deleting all Users"
      User.destroy_all
      puts "Creating test/test development User"
      User.create! :username => "test", :password_hash => User.encrypt("test")
    end
  end 
rescue => e
  puts "error transaction rolled back"
  puts e.message
end
