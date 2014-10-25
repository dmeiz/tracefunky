require 'tracefunky/call'

module Tracefunky

  class Trace
    attr_reader :root

    def initialize
      @root = Call.new(nil, nil, [])
    end
  end
end
