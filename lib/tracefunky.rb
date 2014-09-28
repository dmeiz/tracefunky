require "tracefunky/version"

module Tracefunky
  class Call < Struct.new(:class_name, :method_name, :calls)
    def to_hash
      {:class_name => class_name, :method_name => method_name, :calls => calls}
    end
  end

  class Trace
    private
    attr_reader :root_call, :current_call, :call_stack
    public

    def initialize
      @root_call = Call.new("ROOT", "ROOT", [])
      @current_call = @root
      @call_stack = []
    end

    def run
      set_trace_func Proc.new { |event, file, line, id, the_binding, classname|
#        if event == "call"
#          call = Call.new(klass, id, [])
#          context.current_call[:calls].push(call)
#          context.stack.push(context.current_call)
#          context.current_call = call
#        elsif event == "return"
#          context.current_call = context.stack.pop
#        end
      }

      yield

      set_trace_func nil

      root_call
    end
  end

  def self.trace(&block)
    trace = Trace.new
    root_call = trace.run(&block)
    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
    File.open(".tracefunky/trace.js", "w") do |out|
      JSON.dump(root_call.to_hash, out)
    end
  end
end
