require "spec_helper"

describe Facebook::Base do
  let(:base){ Facebook::Base.new }

  describe "#config" do
    let(:config){ {user_access_token: 'token', page_id: 1234} }

    it "should delegate from Rails configuration" do
      expect(Rails.configuration).to receive(:facebook_config).and_return(config)
      expect(base.config).to eq(config)
    end
  end

end
