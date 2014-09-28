require "tracefunky/version"

module Tracefunky
  class Call < Struct.new(:class_name, :method_name, :calls)
  end

  def self.trace
    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
    File.open(".tracefunky/trace.js", "w") do |out|
      JSON.dump({"class_name" => "ROOT", "method_name" => "ROOT", "calls" => []}, out)
    end
  end
end
