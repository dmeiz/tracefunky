require 'spec_helper'
require 'tracefunky/text_writer'

describe "TextWriter" do
  describe "#write" do
    let(:call) { Tracefunky::Call.new("TestClass", "meth", []) }

    it "should write a call" do
      writer = Tracefunky::TextWriter.open("out.txt")
      writer.write(call)
      writer.close

      txt = File.read("out.txt")
      txt.must_equal "TestClass#meth\n"
    end
  end
end
