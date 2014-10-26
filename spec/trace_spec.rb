require 'spec_helper'
require 'tracefunky/trace'

describe "Trace" do
  let(:trace) { Tracefunky::Trace.new }

  describe "#initialize" do
    it "initializes with a root call" do
      call = trace.root
      call.wont_be_nil
      call.class_name.must_equal nil
      call.method_name.must_equal nil
      call.calls.must_equal []
    end
  end

  describe "#call" do
    it "pushes a new call on the trace" do
      trace.call("TestClass", "meth")

      root_call = trace.root
      root_call.calls.length.must_equal 1

      call = root_call.calls[0]
      call.class_name.must_equal "TestClass"
      call.method_name.must_equal "meth"
      call.calls.must_equal []

      trace.current.must_equal call
      trace.stack.must_equal [root_call]
    end
  end

  describe "#return" do
    before do
      trace.call("TestClass", "meth")
    end

    it "pops a method from the stack" do
      trace.return

      root_call = trace.root
      root_call.calls.length.must_equal 1

      call = root_call.calls[0]
      call.class_name.must_equal "TestClass"
      call.method_name.must_equal "meth"
      call.calls.must_equal []

      trace.current.must_equal root_call
      trace.stack.must_equal []
    end

    # when the stack is empty?
  end
end
