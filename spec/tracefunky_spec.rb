require 'bundler/setup'
require 'minitest/autorun'
require 'pry'
require 'tracefunky'

describe "Tracefunky" do
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

  it "creates a .tracefunky directory" do
    File.exists?(".tracefunky").must_equal false

    Tracefunky.trace do
    end

    File.exists?(".tracefunky").must_equal true
  end

  it "doesn't create .tracefunky directory if it already exists" do
    FileUtils.mkdir ".tracefunky"
    File.exists?(".tracefunky").must_equal true

    Tracefunky.trace do
    end

    File.exists?(".tracefunky").must_equal true
  end
end
