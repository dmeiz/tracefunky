require 'spec_helper'
require 'tracefunky/trace'

describe "Trace" do
  describe "#initialize" do
    it "initializes with a root call" do
      trace = Tracefunky::Trace.new

      call = trace.root
      call.wont_be_nil
      call.class_name.must_equal nil
      call.method_name.must_equal nil
      call.calls.must_equal []
    end
  end
end
