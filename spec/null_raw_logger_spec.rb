require 'spec_helper'
require 'tracefunky/null_raw_logger'

describe "#log" do
  let(:null_raw_logger) { Tracefunky::NullRawLogger.new }

  it "must do nothing" do
    null_raw_logger.log({:foo => "bar"})
  end
end
