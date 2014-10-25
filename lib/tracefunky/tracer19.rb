module Tracefunky

  # Tracer for Ruby 1.9 using the trace_func api.
  #
  class Tracer19
    def run(trace)
      set_trace_func trace_proc(trace)
      yield
      set_trace_func nil
    end

    private

    def trace_proc(trace)
      Proc.new { |event, file, line, id, the_binding, classname|
        if event == "call"
          trace.call(classname.to_s, id.to_s)
        end
      }
    end
  end
end
