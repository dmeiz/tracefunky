require 'spec_helper'
require 'tracefunky/tracer19'

describe "Tracer19" do
  describe "#run" do
    let(:tracer) { Tracefunky::Tracer19.new }
    let(:trace) { nil }

    it "should trace nothing" do
      tracer.run(trace) do
      end
    end
  end
end
