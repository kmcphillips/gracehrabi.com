class BlocksController < ApplicationController
  before_filter :load_block  

  def about
  end

  def contact
  end

  def bio
  end

  def gallery
  end

  def links
    @links = Link.order("created_at ASC")
  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
