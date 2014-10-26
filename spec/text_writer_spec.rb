require 'spec_helper'
require 'tracefunky/text_writer'

describe "TextWriter" do
  before do
    @pwd = FileUtils.pwd
    tmp_dir = "#{@pwd}/tmp"
    FileUtils.rm_r(tmp_dir) if File.exists?(tmp_dir)
    FileUtils.mkdir tmp_dir
    FileUtils.cd tmp_dir
  end

  after do
    FileUtils.cd @pwd
  end

  describe "#write" do
    let(:call) {
      Tracefunky::Call.new("TestClass", "meth", [
        Tracefunky::Call.new("TestClass", "meth2", [] )
      ])
    }

    it "should write a call" do
      writer = Tracefunky::TextWriter.open("out.txt")
      writer.write(call)
      writer.close

      txt = File.read("out.txt")

      txt.must_equal <<END
TestClass#meth
  TestClass#meth2
END
    end
  end
end
