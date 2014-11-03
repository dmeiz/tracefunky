require 'spec_helper'
require 'tracefunky/call'

describe "Call" do
  describe ".root" do
    it "creates a call with nil class and method names" do
      call = Tracefunky::Call.root
      call.class_name.must_equal nil
      call.method_name.must_equal nil
    end
  end

  describe "#root?" do
    it "returns true if calls class and method names are nil" do
      call = Tracefunky::Call.new(nil, nil, [])
      call.root?.must_equal true

      call.class_name = "TestClass"
      call.root?.must_equal false
    end
  end
end
