require 'tracefunky/null_raw_logger'

module Tracefunky

  # Tracer for Ruby 1.9 using the trace_func api.
  #
  class Probe19
    def run(trace, options = {:raw_logger => NullRawLogger.new})
      @raw_logger = options[:raw_logger]
      set_trace_func probe_proc(trace)
      yield
      set_trace_func nil
    end

    private

    def probe_proc(trace)
      Proc.new { |event, file, line, id, the_binding, classname|
        begin
          @raw_logger.log(:event => event, :file => file, :line => line, :id => id, :classname => classname)
          if event == "call"
            trace.call(classname.to_s, id.to_s)
          elsif event == "return"
            trace.return
          end
        rescue ::Exception => e
          set_trace_func nil
          raise e
        end
      }
    end
  end
end
