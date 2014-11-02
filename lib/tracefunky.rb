require "tracefunky/version"
require "tracefunky/trace"
require "tracefunky/text_writer"
require "tracefunky/probe19"

module Tracefunky

  def self.trace(&block)
    trace = Trace.new

    Probe19.new.run(trace, &block)

    writer = TextWriter.open("out.txt")
    writer.write(trace.root)
    writer.close
  end
end
