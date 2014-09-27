require "tracefunky/version"

module Tracefunky
  def self.trace
    FileUtils.mkdir ".tracefunky" unless File.exists?(".tracefunky")
  end
end
