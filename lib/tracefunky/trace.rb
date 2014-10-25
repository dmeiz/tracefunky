require 'tracefunky/call'

module Tracefunky

  class Trace
    attr_reader :root, :current, :stack

    def initialize
      @root = Call.new(nil, nil, [])
      @current = @root
      @stack = []
    end

    def call(class_name, method_name)
      call = Call.new(class_name, method_name, [])
      @current.calls.push(call)
      @stack.push(@current)
      @current = call
    end

    def return
      @current = @stack.pop
    end
  end
end
