require 'spec_helper'
require 'tracefunky/probe2x'

if RUBY_VERSION =~ /\A2.+/
  describe "Probe2x" do
    describe "#run" do
      let(:probe) { Tracefunky::Probe2x.new }
      let(:trace) { TestTrace.new }

      it "should trace nothing" do
        probe.run(trace) do
        end

        trace.events.length.must_equal 0
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
