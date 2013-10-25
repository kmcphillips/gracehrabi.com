class BlocksController < ApplicationController
  before_action :load_block

  def home
    @events = Event.current_and_upcoming.limit(5)
    @posts = Post.recent
    @images = Image.random_sample
  end

  def about
  end

  def contact
  end

  def bio
    @kit = Media.find_by_label!("press_kit")
    render layout: false if pjax_request?
  end

  def gallery
  end

  def links
    @links = Link.in_order
  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
