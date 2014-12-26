require 'tracefunky/null_raw_logger'

module Tracefunky

  # Tracer for Ruby 2.x using the trace_func api.
  #
  class Probe2x

    private

    # untested
    def log_raw_tracepoint(tp)
      @raw_logger.log(
        :event => tp.event,
        :lineno => tp.lineno,
        :method_id => tp.method_id,
        :path => tp.path,
        :raised_exception => tp.event == :raise ? tp.raised_exception : nil,
        :return_value => [:return, :c_return, :b_return].include?(tp.event) ? tp.return_value : nil,
        :defined_class => tp.defined_class
      )
    end

    public

    def run(trace, options = {:raw_logger => NullRawLogger.new})
      @raw_logger = options[:raw_logger]

      trace_point = TracePoint.new(:call, :return) do |tp|
        log_raw_tracepoint(tp)

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
