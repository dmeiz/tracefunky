module Tracefunky

  # A method call.
  #
  class Call < Struct.new(:class_name, :method_name, :calls)
  end
end
