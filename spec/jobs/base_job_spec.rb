require "spec_helper"

describe BaseJob do
  class TestJob < BaseJob
    def initialize(arg1, arg2)
      @arg1 = arg1
      @arg2 = arg2
    end
  end

  before do
    ResqueSpec.reset!
  end

  describe "class method" do
    describe "#enqueue" do
      it "should enque the expected job" do
        TestJob.enqueue('1', '2')
        expect(TestJob).to have_queue_size_of(1)
        expect(TestJob).to have_queued('1', '2')
      end
    end

    describe "#queue" do
      it "should be default by default" do
        expect(TestJob.queue).to eq(:default)
      end
    end
  end
end
