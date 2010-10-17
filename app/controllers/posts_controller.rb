class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def rss
    @items = (Post.all(:order => "created_at DESC") + Event.all(:order => "starts_at DESC")).sort{|x,y| x.sort_by <=> y.sort_by}
    
    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end
end
