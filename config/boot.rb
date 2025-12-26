ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Fix for Ruby 3.3+ compatibility
# Logger was removed from default gems in Ruby 3.3
require 'logger'

# Enable YAML aliases for Ruby 3.1+
# This is needed for database.yml to work with aliases
require 'psych'
module Psych
  class << self
    alias original_load load

    def load(yaml, **kwargs)
      kwargs[:aliases] = true unless kwargs.key?(:aliases)
      original_load(yaml, **kwargs)
    end
  end
end
