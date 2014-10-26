require 'spec_helper'
require 'tracefunky/text_writer'

describe "TextWriter" do
  before do
    @pwd = FileUtils.pwd
    scratch_dir = "#{@pwd}/scratch"
    FileUtils.rm_r(scratch_dir) if File.exists?(scratch_dir)
    FileUtils.mkdir scratch_dir
    FileUtils.cd scratch_dir
  end

  after do
    FileUtils.cd @pwd
  end

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
