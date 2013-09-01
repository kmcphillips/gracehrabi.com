require 'spec_helper'

describe Admin::BlocksController do
  let(:block){ FactoryGirl.create(:block) }
  let(:block_attributes){ {'body' => 'body of the block'} }

  before(:each) do
    login_as_user
  end

  describe "GET index" do
    it "assigns all blocks as @blocks" do
      Block.stub(:order) { [block] }
      get :index
      assigns(:blocks).should eq([block])
    end
  end

  describe "GET edit" do
    it "assigns the requested block as @block" do
      Block.stub(:find).with("37") { block }
      get :edit, id: "37"
      assigns(:block).should be(block)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested block" do
        Block.should_receive(:find).with("37").and_return(block)
        block.should_receive(:update_attributes).with(block_attributes)
        put :update, id: "37", block: block_attributes
      end

      it "assigns the requested block as @block" do
        block.stub(update_attributes: true)
        Block.stub(find: block)
        put :update, id: "1", block: block_attributes
        assigns(:block).should be(block)
      end

      it "redirects to the block" do
        block.stub(update_attributes: true)
        Block.stub(find: block)
        put :update, id: "1", block: block_attributes
        response.should redirect_to(admin_blocks_path)
      end
    end

    describe "with invalid params" do
      it "assigns the block as @block" do
        block.stub(update_attributes: false)
        Block.stub(find: block)
        put :update, id: "1", block: block_attributes
        assigns(:block).should be(block)
      end

      it "re-renders the 'edit' template" do
        block.stub(update_attributes: false)
        Block.stub(find: block)
        put :update, id: "1", block: block_attributes
        response.should render_template("edit")
      end
    end
  end
end
