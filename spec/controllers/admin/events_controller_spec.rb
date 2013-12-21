require 'spec_helper'

describe Admin::EventsController do
  let(:event){ FactoryGirl.create(:event) }
  let(:event_attributes){ {"title" => "Event title", "description" => "Event description", "starts_at" => "2013-01-01 01:01:10"} }

  before(:each) do
    login_as_user
  end

  describe "GET index" do
    it "assigns all events as @events" do
      Event.stub(:page) { [event] }
      get :index
      assigns(:events).should eq([event])
    end
  end

  describe "GET new" do
    it "assigns a new event as @event" do
      get :new
      assigns(:event).should be_an_instance_of(Event)
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      Event.stub(:find).with("37") { event }
      get :edit, id: "37"
      assigns(:event).should be(event)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created event as @event" do
        event.stub(save: true)
        Event.stub(:new).with(event_attributes) { event }
        post :create, event: event_attributes
        assigns(:event).should be(event)
      end

      it "redirects to the created event" do
        event.stub(save: true)
        Event.stub(:new) { event }
        post :create, event: event_attributes
        response.should redirect_to(admin_events_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        event.stub(save: false)
        Event.stub(:new).with(event_attributes) { event }
        post :create, event: event_attributes
        assigns(:event).should be(event)
      end

      it "re-renders the 'new' template" do
        event.stub(save: false)
        Event.stub(:new) { event }
        post :create, event: event_attributes
        response.should render_template("new")
      end
    end
    
    describe "preview" do
      it "should render" do
        event.stub(:valid?).and_return(true)
        Event.stub(:new).with(event_attributes) { event }
        post :create, event: event_attributes, commit: "Preview"
        response.should render_template("edit")
      end
    end
  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested event" do
        Event.should_receive(:find).with("37") { event }
        event.should_receive(:update_attributes).with(event_attributes)
        put :update, id: "37", event: event_attributes
      end

      it "assigns the requested event as @event" do
        event.stub(update_attributes: true)
        Event.stub(:find) { event }
        put :update, id: "1", event: event_attributes
        assigns(:event).should be(event)
      end

      it "redirects to the event" do
        event.stub(update_attributes: true)
        Event.stub(:find) { event }
        put :update, id: "1", event: event_attributes
        response.should redirect_to(admin_events_url)
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        event.stub(update_attributes: false)
        Event.stub(:find) { event }
        put :update, id: "1", event: event_attributes
        assigns(:event).should be(event)
      end

      it "re-renders the 'edit' template" do
        event.stub(update_attributes: false)
        Event.stub(:find) { event }
        put :update, id: "1", event: event_attributes
        response.should render_template("edit")
      end
    end
    
    describe "preview" do
      it "should check the commit and preview" do
        Event.stub(:find) { event }
        event.should_receive(:attributes=)
        event.should_receive(:valid?)
        put :update, id: "1", commit: "Preview", event: event_attributes
        assigns(:event).should be(event)
        assigns(:preview).should be_true
      end
      
      it "should render" do
        event.stub(:attributes= => true, :valid? => nil)
        Event.stub(:find) { event }
        put :update, id: "1", commit: "Preview", event: event_attributes
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested event" do
      Event.should_receive(:find).with("37") { event }
      event.should_receive(:destroy)
      delete :destroy, id: "37"
    end

    it "redirects to the events list" do
      Event.stub(:find) { event }
      delete :destroy, id: "1"
      response.should redirect_to(admin_events_url)
    end
  end

end
