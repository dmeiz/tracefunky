require "tracefunky/version"
require "tracefunky/trace"
require "tracefunky/text_writer"
require "tracefunky/probe19"
require "tracefunky/probe2x"
require "tracefunky/utils"

module Tracefunky

  def self.trace(&block)
    trace = Trace.new

    if is_ruby2x?
      Probe2x.new.run(trace, &block)
    else
      Probe19.new.run(trace, &block)
    end

    writer = TextWriter.open("out.txt")
    writer.write(trace.root)
    writer.close
  end
end
