module Tracefunky

  # Tracer for Ruby 1.9 using the trace_func api.
  #
  class Probe19
    def run(trace)
      set_trace_func probe_proc(trace)
      yield
      set_trace_func nil
    end

    private

    def probe_proc(trace)
      Proc.new { |event, file, line, id, the_binding, classname|
        if event == "call"
          trace.call(classname.to_s, id.to_s)
        end
      }
    end
  end
end
