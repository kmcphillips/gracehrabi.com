class Admin::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.order("created_at DESC").per_page_kaminari(params[:page])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by_permalink!(params[:id])
  end

  def create
    @post = Post.new(post_params)

    if params[:commit] == "Preview"
      @post.valid?
      @preview = true
      render :action => "edit"
    elsif @post.save
      redirect_to(admin_posts_url, :notice => 'Post was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find_by_permalink!(params[:id])

    if params[:commit] == "Preview"
      @post.attributes = post_params
      @post.valid?
      @preview = true
      render :action => "edit"
    elsif @post.update_attributes(post_params)
      redirect_to(admin_posts_url, :notice => 'Post was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find_by_permalink!(params[:id])
    @post.destroy

     redirect_to(admin_posts_url) 
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :clear_image, :previous_image_id)
  end

end
