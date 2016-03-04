require "i18n"

I18n.load_path      = Dir["../lib/locales/*.yml"]
I18n.default_locale = ENV["LOCALE"] || :en

begin
  require "win32console"
rescue LoadError
end

# --------------------------------------------------------------------
# Support code for the Ruby Koans.
# --------------------------------------------------------------------

class FillMeInError < StandardError
end

def ruby_version?(version)
  RUBY_VERSION =~ /^#{version}/ ||
    (version == "jruby" && defined?(JRUBY_VERSION)) ||
    (version == "mri" && ! defined?(JRUBY_VERSION))
end

def in_ruby_version(*versions)
  yield if versions.any? { |v| ruby_version?(v) }
end

# Standard, generic replacement value.
# If value19 is given, it is used in place of value for Ruby 1.9.
def __(value = I18n.t("neo.fill_me_in"), value19 = :mu)
  if RUBY_VERSION < "1.9"
    value
  else
    (value19 == :mu) ? value : value19
  end
end

# Numeric replacement value.
def _n_(value=999999, value19=:mu)
  if RUBY_VERSION < "1.9"
    value
  else
    (value19 == :mu) ? value : value19
  end
end

# Error object replacement value.
def ___(value=FillMeInError, value19=:mu)
  if RUBY_VERSION < "1.9"
    value
  else
    (value19 == :mu) ? value : value19
  end
end

module Neo
  class << self
    def simple_output
      ENV["SIMPLE_KOAN_OUTPUT"] == "true"
    end
  end
end

require_relative "core_extensions/object"
require_relative "neo/assertions"
require_relative "neo/koan"
require_relative "neo/sensei"
require_relative "neo/the_path"
