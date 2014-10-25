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
    @events << {
      :type => :call,
      :class_name => class_name,
      :method_name => method_name
    }
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
  end
end
