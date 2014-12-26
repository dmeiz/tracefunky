require "tracefunky/version"
require "tracefunky/trace"
require "tracefunky/text_writer"
require "tracefunky/probe19"
require "tracefunky/probe2x"
require "tracefunky/utils"

module Tracefunky

  def self.trace(&block)
    trace = Trace.new

    if ruby2x?
      Probe2x.new.run(trace, probe_options, &block)
    else
      Probe19.new.run(trace, probe_options, &block)
    end

    writer = TextWriter.open("out.txt")
    writer.write(trace.root)
    writer.close
  end

  def self.probe_options
    { :raw_logger => NullRawLogger.new }
  end
end
