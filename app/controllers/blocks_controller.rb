class BlocksController < FrontEndController
  before_action :load_block

  def home
  end

  def about
    @links = Link.in_order
  end

  def gallery
    @images = Image.all_active.in_order
  end

  def music
  end

  def listen
  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
