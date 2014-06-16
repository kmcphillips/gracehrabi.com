require "spec_helper"

class ExampleJob < BackgroundJob
end

describe ExampleJob do
  let(:job){ ExampleJob.new }

  describe "#log_info" do
    it "should make logging available" do
      expect(Rails.logger).to receive(:info).with("ExampleJob -- test")
      job.send(:log_info, 'test')
    end

    it "should make logging available" do
      expect(Rails.logger).to receive(:info).with("ExampleJob -- test")
      job.send(:log, 'test')
    end
  end

  describe "#log_error" do
    it "should make logging available" do
      expect(Rails.logger).to receive(:error).with("ExampleJob -- test")
      job.send(:log_error, 'test')
    end
  end
end
