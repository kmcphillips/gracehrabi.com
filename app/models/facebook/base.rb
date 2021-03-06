class Facebook::Base
  attr_reader :user_access_token

  def initialize(user_access_token=nil)
    @user_access_token = user_access_token
  end

  def config
    Rails.configuration.facebook_config
  end

  # def app_graph
  #   @app_graph ||= Koala::Facebook::API.new(config["app_id"], config["app_secret"])
  # end

  def user_graph
    @user_graph ||= Koala::Facebook::API.new(user_access_token)
  end

  def page_graph
    @page_graph ||= Koala::Facebook::API.new(page_token)
  end

  def page_url
    config["page_url"]
  end

  protected

  def page_token
    user_graph.get_page_access_token(config["page_id"])
  end

end
