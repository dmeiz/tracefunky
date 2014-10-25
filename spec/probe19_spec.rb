require 'spec_helper'
require 'tracefunky/probe19'

# A trace that just collects information from the probe to verify in specs.
#
class TestTrace
  attr_reader :events

  def initialize
    @events = []
  end

  def call(class_name, method_name)
    @events << [ :call, class_name, method_name ]
  end
end

class TestClass
  def meth
  end
end

describe "Probe19" do
  describe "#run" do
    let(:probe) { Tracefunky::Probe19.new }
    let(:trace) { TestTrace.new }

    it "should trace nothing" do
      probe.run(trace) do
      end
    end

    it "should trace a method call" do
      klass = TestClass.new

      probe.run(trace) do
        klass.meth
      end

      trace.events.length.must_equal 1
      trace.events[0].must_equal [ :call, "TestClass", "meth" ]
    end
  end
end
