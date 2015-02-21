require 'text-table'

module Tracefunky
  class TableRawLogger
    SORTED_POSSIBLE_KEYS = [:event, :classname, :defined_class, :method_id, :id, :file, :path, :line, :lineno, :raised_exception, :return_value]

    def initialize
      @table = Text::Table.new
    end

    def log(params)
      if @table.rows.empty?
        @actual_keys = SORTED_POSSIBLE_KEYS.select { |key| params.has_key?(key) }
        @table.head = @actual_keys.map { |key| key.to_s }
      end

      @table.rows << @actual_keys.map { |key| params[key].to_s }
    end

    def write(out)
      out.write(@table.to_s)
    end
  end
end
