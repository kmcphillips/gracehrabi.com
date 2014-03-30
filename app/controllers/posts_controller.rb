class PostsController < ApplicationController

  def index
    @posts = Post.sorted.page(params[:page])
    @title = "News"
  end

  def show
    @post = Post.find_by_permalink!(params[:id])
    @title = @post.title
  end

  def rss
    @items = (Post.sorted + Event.sorted).sort{|x,y| x.sort_by <=> y.sort_by}
    
    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end
end
