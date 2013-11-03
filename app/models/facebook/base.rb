class Facebook::Base
  def config
    Rails.configuration.facebook_config
  end

  def user_graph
    @user_graph ||= Koala::Facebook::API.new(config["user_access_token"])
  end

  def page_graph
    @page_graph ||= Koala::Facebook::API.new(page_token)
  end

  protected

  def page_token
    user_graph.get_page_access_token(config["page_id"])
  end

end
