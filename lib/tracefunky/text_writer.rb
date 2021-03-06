require 'tracefunky/call'

module Tracefunky
  class TextWriter
    def self.open(filename)
      TextWriter.new(filename)
    end

    def initialize(filename)
      @out = File.open(filename, "w")
    end

    def write(call, depth = 0)
      if call.root?
        call.calls.each { |c| write(c, depth) }
      else
        @out.puts("#{" " * depth * 2 }#{call.class_name}##{call.method_name}")
        call.calls.each { |c| write(c, depth + 1) }
      end
    end

    def close
      @out.close
    end
  end
end
