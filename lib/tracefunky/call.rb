module Tracefunky

  # A method call.
  #
  class Call < Struct.new(:class_name, :method_name, :calls)

    # Create a root call, the call at the top of a call heirarchy.
    #
    def self.root
      new(nil, nil, [])
    end

    # Returns true if this is a root call
    #
    def root?
      class_name == nil && method_name == nil
    end
  end
end
