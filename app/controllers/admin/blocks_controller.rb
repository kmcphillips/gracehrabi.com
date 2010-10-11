class Admin::BlocksController < ApplicationController
  before_filter :require_login

  def index
    @blocks = Block.all
  end

  def show
    @block = Block.find(params[:id])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    @block = Block.find(params[:id])

    respond_to do |format|
      if @block.update_attributes(params[:block])
        redirect_to(admin_blocks_path, :notice => 'Block was successfully updated.')
      else
        render :action => "edit"
      end
    end
  end

end
