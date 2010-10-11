require 'spec_helper'

describe BlocksController do

  def mock_block(stubs={})
    @mock_block ||= mock_model(Block, stubs).as_null_object
  end

  describe "GET about" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("about") { mock_block }
      get "about"
      assigns(:block).should be(mock_block)
    end
  end

  describe "GET contact" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("contact") { mock_block }
      get "contact"
      assigns(:block).should be(mock_block)
    end
  end

end
