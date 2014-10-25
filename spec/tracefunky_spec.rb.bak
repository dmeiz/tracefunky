require 'bundler/setup'
require 'minitest/autorun'
require 'pry'
require 'tracefunky'
require 'json'

class TestClass
  def simple_method
    simple_method2
  end

  def simple_method2
  end
end

describe "Tracefunky" do
  before do
    @pwd = FileUtils.pwd
    
    scratch_dir = "#{@pwd}/scratch"
    FileUtils.rm_r(scratch_dir) if File.exists?(scratch_dir)
    FileUtils.mkdir scratch_dir
    FileUtils.cd scratch_dir

    @test_class = TestClass.new
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

  it "must trace an empty block" do
    Tracefunky.trace do
    end

    File.exists?(".tracefunky/trace.out").must_equal true
    trace = JSON.parse(File.read(".tracefunky/trace.out"))
    trace.must_equal({"class_name" => "ROOT", "method_name" => "ROOT", "calls" => []})
  end

  it "must trace a simple method call" do
    Tracefunky.trace do
      @test_class.simple_method
      @test_class.simple_method2
    end

    trace = JSON.parse(File.read(".tracefunky/trace.out"))
    trace.must_equal(
      {
        "class_name" => "ROOT",
        "method_name" => "ROOT",
        "calls" => [
          {
            "class_name" => "TestClass",
            "method_name" => "simple_method",
            "calls" => [
              {
                "class_name" => "TestClass",
                "method_name" => "simple_method2",
                "calls" => []
              }
            ]
          },
          {
            "class_name" => "TestClass",
            "method_name" => "simple_method2",
            "calls" => []
          }
        ]
      }
    )
  end
end
