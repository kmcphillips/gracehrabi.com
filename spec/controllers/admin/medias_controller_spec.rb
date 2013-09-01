require 'spec_helper'

describe Admin::MediasController do
  let(:media){ FactoryGirl.create(:media) }
  let(:media_attributes){ {'file' => ''} }

  before(:each) do
    login_as_user
  end

  describe "GET edit" do
    it "assigns the requested media as @kit" do
      Media.stub(:find_by_label!).with("37") { media }
      get :edit, id: "37"
      assigns(:kit).should be(media)
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested media" do
        Media.should_receive(:find_by_label!).with("37") { media }
        media.should_receive(:update_attributes)
        put :update, id: "37", media: media_attributes
      end

      it "assigns the requested media as @media" do
        media.stub(update_attributes: true, label: "press_kit")
        Media.stub(:find_by_label!) { media }
        put :update, id: "1", media: media_attributes
        assigns(:kit).should be(media)
      end

      it "redirects to the media" do
        media.stub(update_attributes: true, label: "press_kit")
        Media.stub(:find_by_label!) { media }
        put :update, id: "1", media: media_attributes
        response.should redirect_to(admin_blocks_path)
      end
    end

    describe "with invalid params" do
      it "assigns the media as @media" do
        media.stub(update_attributes: false)
        Media.stub(:find_by_label!) { media }
        put :update, id: "1", media: media_attributes
        assigns(:kit).should be(media)
      end

      it "re-renders the 'edit' template" do
        media.stub(update_attributes: false)
        Media.stub(:find_by_label!) { media }
        put :update, id: "1", media: media_attributes
        response.should render_template("edit")
      end
    end

  end

end
