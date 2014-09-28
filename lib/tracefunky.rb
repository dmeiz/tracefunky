require "tracefunky/version"

module Tracefunky
  class Call < Struct.new(:class_name, :method_name, :calls)
    def to_hash
      {:class_name => class_name, :method_name => method_name, :calls => calls}
    end
  end

  def self.trace
    root_call = Call.new("ROOT", "ROOT", [])
    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
    File.open(".tracefunky/trace.js", "w") do |out|
      JSON.dump(root_call.to_hash, out)
    end
  end
end
