require 'minitest/autorun'
require 'fileutils'
require 'pry'

# A trace that just collects information from the probe to verify in specs.
#
class TestTrace
  attr_reader :events

  def initialize
    @events = []
  end

  def call(class_name, method_name)
    @events << [ :call, class_name, method_name ]
  end

  def return
    @events << [ :return ]
  end
end

# A fixture class for testing.
#
class TestClass
  def meth
  end
end

class TestRawLogger
  attr_reader :events

  def initialize
    @events = []
  end

  def log(params)
    @events << params
  end
end
