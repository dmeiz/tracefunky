module Tracefunky
  def self.ruby2x?
    RUBY_VERSION =~ /\A2.+/
  end
end
