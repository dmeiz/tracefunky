require "tracefunky/version"

module Tracefunky
  class Call < Struct.new(:class_name, :method_name, :calls)
  end

  class Ruby19Trace
    def trace

    end
  end

  def self.trace
    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
#    File.new(".tracefunky/trace.js", "w") do |out|
#      out.print "hello"
#    end
  end
end
