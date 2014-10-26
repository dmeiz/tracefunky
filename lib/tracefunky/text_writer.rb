require 'tracefunky/call'

module Tracefunky
  class TextWriter
    def self.open(filename)
      TextWriter.new(filename)
    end

    def initialize(filename)
      @out = File.open(filename, "w")
    end

    def write(call)
      @out.puts("#{call.class_name}##{call.method_name}")
    end

    def close
      @out.close
    end
  end
end
