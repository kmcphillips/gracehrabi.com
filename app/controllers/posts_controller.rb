class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def rss
    @posts = Post.all(:order => "created_at DESC").limit(20)
    
    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end
end
