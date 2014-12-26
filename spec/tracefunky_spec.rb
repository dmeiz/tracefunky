require 'spec_helper'
require 'tracefunky'

describe "Tracefunky" do
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

  describe ".trace" do
    test_class = TestClass.new
    it "traces a call" do
      Tracefunky.trace do
        test_class.meth
      end

      File.read("out.txt").must_equal <<END
TestClass#meth
END
    end
  end

  describe ".probe_options" do
    it "must return default options" do
      options = Tracefunky.probe_options
      options[:raw_logger].must_be_kind_of Tracefunky::NullRawLogger
    end
  end
end
