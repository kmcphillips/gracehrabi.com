class Admin::LinksController < ApplicationController

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(params[:link])

    if @link.save
      redirect_to([:admin, @link], :notice => 'Link was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to([:admin, @link], :notice => 'Link was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    redirect_to(admin_links_url)
  end
end