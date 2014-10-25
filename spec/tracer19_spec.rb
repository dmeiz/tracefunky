require 'spec_helper'
require 'tracefunky/tracer19'

# A trace that just collects information from the tracer to verify in specs.
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

describe "Tracer19" do
  describe "#run" do
    let(:tracer) { Tracefunky::Tracer19.new }
    let(:trace) { TestTrace.new }

    it "should trace nothing" do
      tracer.run(trace) do
      end
    end

    it "should trace a method call" do
      klass = TestClass.new

      tracer.run(trace) do
        klass.meth
      end

      trace.events.length.must_equal 1
      trace.events[0].must_equal [ :call, "TestClass", "meth" ]
    end
  end
end
