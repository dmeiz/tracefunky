require 'spec_helper'
require 'tracefunky/probe19'
require 'tracefunky/utils'

unless Tracefunky.ruby2x?
  describe "Probe19" do
    describe "#run" do
      let(:probe) { Tracefunky::Probe19.new }
      let(:trace) { TestTrace.new }

      it "should trace nothing" do
        probe.run(trace) do
        end
      end

      it "should accept a :raw_logger option" do
        klass = TestClass.new
        test_raw_logger = TestRawLogger.new

        probe.run(trace, {:raw_logger => test_raw_logger}) do
          klass.meth
        end

        test_raw_logger.events.length.must_be :>, 0
        test_raw_logger.events[0].must_be_kind_of Hash
      end

      it "should trace a method call and return" do
        klass = TestClass.new

        probe.run(trace) do
          klass.meth
        end

        trace.events.length.must_equal 2
        trace.events[0].must_equal [ :call, "TestClass", "meth" ]
        trace.events[1].must_equal [ :return ]
      end
    end
  end
end
