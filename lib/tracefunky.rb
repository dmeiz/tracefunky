require "tracefunky/version"

module Tracefunky

  def self.trace(&block)
    trace = Trace.new
    Probe19.new.run(trace)
    trace

    root_call = trace.run(&block)

    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
    File.open(".tracefunky/trace.out", "w") do |out|
      PP.pp(root_call.to_hash, out)
    end
  end
end
