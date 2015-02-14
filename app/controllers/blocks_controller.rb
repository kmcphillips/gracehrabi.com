class BlocksController < FrontEndController
  before_action :load_block

  def home
    @about = Block.find_by_label('about')
    @title = ""
  end

  def gallery
    @images = Image.all_active.in_order
  end

  def media
    @title = "Electronic Press Kit"
  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
