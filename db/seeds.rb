begin
  ActiveRecord::Base.transaction do

    ## Blocks
    puts "Deleting all Blocks"
    Block.destroy_all
    puts "Creating Blocks"

    {"contact" => "/contact", "about" => "/about"}.each_pair do |k, v|
      b = Block.new :body => ""
      b.label = k
      b.path = v
      b.accepts_image = true if k = "contact"
      b.save!
    end

  end 
rescue => e
  puts "Error! Transaction rolled back"
  puts e.message
end
