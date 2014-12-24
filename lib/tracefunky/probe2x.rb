module Tracefunky

  # Tracer for Ruby 2.x using the trace_func api.
  #
  class Probe2x
    def run(trace)
      trace_point = TracePoint.new(:call, :return) do |tp|
        if tp.event == :call
          trace.call(tp.defined_class.to_s, tp.method_id.to_s)
        elsif tp.event == :return
          trace.return
        end
      end

      trace_point.enable
      yield
      trace_point.disable
    end
  end
end
