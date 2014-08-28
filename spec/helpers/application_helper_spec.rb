require 'spec_helper'

describe ApplicationHelper do
  describe "page title" do
    it "should build a default page title" do
      controller.stub(params: {controller: "pie"})
      controller.instance_variable_set('@title', "Cake")
      helper.page_title.should == "Grace Hrabi - Cake"
    end

    it "should build a title from the controller" do
      controller.stub(params: {controller: "pie"})
      helper.page_title.should == "Grace Hrabi - Pie"
    end

    it "should build a page title for your controller" do
      controller.stub(params: {controller: "pie"})
      controller.instance_variable_set('@title', "Delicious")
      helper.page_title.should == "Grace Hrabi - Delicious"
    end

    it "should show default admin" do
      controller.stub(params: {controller: "admin/pie"})
      helper.page_title.should == "Grace Hrabi - Admin"
    end

    it "should prepend admin if you are under admin" do
      controller.stub(params: {controller: "admin/pie"})
      controller.instance_variable_set('@title', "Delicious")
      helper.page_title.should == "Grace Hrabi - Admin - Delicious"
    end

    it "should makes special exception for the blocks controller" do
      controller.stub(params: {controller: "blocks", action: "eat"})
      helper.page_title.should == "Grace Hrabi - Eat"
    end

    it "should do the same for blocks controller under admin" do
      controller.stub(params: {controller: "admin/blocks", action: "eat"})
      helper.page_title.should == "Grace Hrabi - Admin - Eat"
    end
  end

  describe "error messages" do
    let(:obj){ double }

    it "should render the partial" do
      helper.should_receive(:render).with(partial: "/shared/flash_error_messages", object: obj).and_return("pie")
      helper.error_messages(obj).should eq("pie")
    end
  end

  describe "admin?" do
    it "should know if it is not admin" do
      controller.stub(params: {controller: "posts"})
      helper.admin?.should be_falsey
    end

    it "should know if it is admin" do
      controller.stub(params: {controller: "admin/posts"})
      helper.admin?.should be_truthy
    end
  end

  describe "meta_from_settings" do
    subject{ helper.meta_from_settings }

    its(:size){ should > 0 }

    it "should contain the expected keys" do
      Settings.meta.each do |name, content|
        expect(subject).to include(" name=\"#{name}\"")
      end
    end
  end

end
