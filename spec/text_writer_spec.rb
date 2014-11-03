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
      Tracefunky::Call.new("TestClass", "meth", [])
    }

    it "should write a call" do
      writer = Tracefunky::TextWriter.open("out.txt")
      writer.write(call)
      writer.close

      txt = File.read("out.txt")

      txt.must_equal <<END
TestClass#meth
END
    end

    it "should write a call heirarchy" do
      call.calls << Tracefunky::Call.new("TestClass", "meth2", [] )

      writer = Tracefunky::TextWriter.open("out.txt")
      writer.write(call)
      writer.close

      txt = File.read("out.txt")

      txt.must_equal <<END
TestClass#meth
  TestClass#meth2
END
    end

    it "shouldnt write name for a root call" do
      root = Tracefunky::Call.root
      root.calls << Tracefunky::Call.new("TestClass", "meth", [])

      writer = Tracefunky::TextWriter.open("out.txt")
      writer.write(root)
      writer.close

      txt = File.read("out.txt")

      txt.must_equal <<END
TestClass#meth
END
    end
  end
end
