require "tracefunky/version"

module Tracefunky
  class Call < Struct.new(:class_name, :method_name, :calls)
    def to_hash
      {:class_name => class_name, :method_name => method_name, :calls => calls.map {|call| call.to_hash}}
    end
  end

  class StdoutRawLogger
    def log(event)
      PP.pp event
    end
  end

  class Trace
    private
    attr_reader :root_call, :call_stack, :raw_logger
    public

    class NullRawLogger
      def log(event)
      end
    end

    def initialize(options = {:raw_logger => NullRawLogger.new})
      @raw_logger = options[:raw_logger]
      @root_call = Call.new("ROOT", "ROOT", [])
      @call_stack = []
      @current_call = @root_call
    end

    def print_state(at)
      puts at
      puts "current_call:"
      PP.pp @current_call
      puts "call_stack:"
      PP.pp @call_stack
      puts "-" * 20
    end

    def run
      set_trace_func Proc.new { |event, file, line, id, the_binding, classname|
        if event == "call"
          #puts({:event => event, :file => file, :line => line, :id => id, :classname => classname})
          #print_state "before call"
          raw_logger.log("#{classname}##{id}")
          call = Call.new(classname.to_s, id.to_s, [])
          @current_call.calls.push(call)
          @call_stack.push(@current_call)
          @current_call = call
          #print_state "after call"
        elsif event == "return"
          #puts({:event => event, :file => file, :line => line, :id => id, :classname => classname})
          #print_state "before return"
          @current_call = @call_stack.pop
          puts @call_stack.length
          #print_state "after return"
        end
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
    File.open(".tracefunky/trace.out", "w") do |out|
      PP.pp(root_call.to_hash, out)
    end
  end
end
