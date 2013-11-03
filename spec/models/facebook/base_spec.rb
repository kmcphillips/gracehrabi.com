require "spec_helper"

describe Facebook::Base do
  let(:base){ Facebook::Base.new }
  let(:config){ {"user_access_token" => user_access_token, "page_id" => page_id, "page_url" => page_url} }
  let(:user_access_token){ 'token' }
  let(:page_id){ 12345 }
  let(:page_token){ 'page_token' }
  let(:page_url){ 'http://page.url' }

  before(:each) do
    allow(Rails.configuration).to receive(:facebook_config).and_return(config)
  end

  describe "#config" do
    it "should delegate from Rails configuration" do
      expect(Rails.configuration).to receive(:facebook_config).and_return(config)
      expect(base.config).to eq(config)
    end
  end

  describe "#user_graph" do
    it "should make a new API object using the access_token" do
      graph = base.user_graph
      expect(graph).to be_an_instance_of(Koala::Facebook::API)
      expect(graph.access_token).to eq(user_access_token)
    end

    it "should memoize" do
      expect(base.user_graph).to eql(base.user_graph)
    end
  end

  describe "#page_graph" do
    before(:each) do
      allow(base).to receive(:page_token).and_return(page_token)
    end

    it "should make a new API object using the page_id and the user_graph" do
      expect(base).to receive(:page_token).and_return(page_token)
      graph = base.page_graph
      expect(graph).to be_an_instance_of(Koala::Facebook::API)
      expect(graph.access_token).to eq(page_token)
    end

    it "should memoize" do
      expect(base.page_graph).to eql(base.page_graph)
    end
  end

  describe "#page_token" do
    let(:user_graph){ double }

    it "should pull the token from the user_graph and the page_id" do
      expect(base).to receive(:user_graph).and_return(user_graph)
      expect(user_graph).to receive(:get_page_access_token).with(page_id).and_return(page_token)
      expect(base.send(:page_token)).to eq(page_token)
    end
  end

  describe "#page_url" do
    it "should pull the URL from the options" do
      expect(base.page_url).to eq(page_url)
    end
  end

end
