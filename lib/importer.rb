class Importer
  include ActionView::Helpers::SanitizeHelper
  
  def initialize(config)
    keys = %w(host username password schema)
    raise "Invalid params. Requires: #{keys.join(", ")}." unless keys.inject(true){|acc,key| acc && config[key]}
    
    puts "Connecting to database '#{config["schema"]}' with user '#{config["username"]}'..."
    @db = Mysql2::Client.new(
        :host => config["host"], 
        :username => config["username"], 
        :password => config["password"], 
        :database => config["schema"]
    )
    puts "Connected"
  end
  
  def import!
    begin
      ActiveRecord::Base.transaction do
        import_bio
        import_contact
        import_events
        import_blog
      end
    rescue => e
      puts "*** ERROR: Transaction rolled back becasue of exception raised! ***"
      raise e
    end
  end
  
  protected
  
  def import_bio
    puts "Importing bio..."
    b = Block.find_by_label!("bio")
    result = @db.query("SELECT * FROM bio").first
    
    b.body = scrub(result[:body])
    b.save!
    puts "Done"
  end

  def import_contact
    puts "Importing contact..."
    b = Block.find_by_label!("contact")
    result = @db.query("SELECT * FROM contact").first

    b.body = scrub(result[:body])
    b.save!
    puts "Done"
  end
  
  def import_blog
    puts "Importing blog..."
    @db.query("SELECT * FROM blog").each do |result|
      post = Post.new(:title => result["title"], :body => scrub(result["body"]), :created_at => result["create_date"], :updated_at => result["create_date"])
      post.save!
      puts "  Blog post ##{post.id} created"
    end
    puts "Done"
  end

  def import_events
    puts "Importing events..."
    @db.query("SELECT * FROM event").each do |result|
      event = Event.new(:title => result["title"], :description => scrub(result["description"]), :starts_at => result["date"], :created_at => result["create_date"], :updated_at => result["create_date"])
      event.save!
      puts "  Event ##{event.id} created"
    end
    puts "Done"
  end

  def scrub(str)
    str.gsub(/<br *\/?>/, "\n").strip_html
  end
end
