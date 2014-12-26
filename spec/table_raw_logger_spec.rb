require 'spec_helper'
require 'tracefunky/table_raw_logger'

describe "#log" do
  let(:table_raw_logger) { Tracefunky::TableRawLogger.new }
  let(:out) { StringIO.new }

  it "creates a heading from params keys" do
    table_raw_logger.log({:event => "call"})
    table_raw_logger.write(out)
    out.string.must_equal <<-END
+-------+
| event |
+-------+
| call  |
+-------+
END
  end

  it "supports Probe19 and Probe2x keys" do
    params = {}
    Tracefunky::TableRawLogger::SORTED_POSSIBLE_KEYS.each do |key|
      params[key] = key.to_s
    end
    params[:unsupported] = "unsupported"

    table_raw_logger.log(params)
    table_raw_logger.write(out)
    out.string.must_equal <<-END
+-------+-----------+---------------+-----------+----+------+------+------+--------+------------------+--------------+
| event | classname | defined_class | method_id | id | file | path | line | lineno | raised_exception | return_value |
+-------+-----------+---------------+-----------+----+------+------+------+--------+------------------+--------------+
| event | classname | defined_class | method_id | id | file | path | line | lineno | raised_exception | return_value |
+-------+-----------+---------------+-----------+----+------+------+------+--------+------------------+--------------+
END
  end
end
