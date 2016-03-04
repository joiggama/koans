module Neo
  module Assertions
    FailedAssertionError = Class.new(StandardError)

    def flunk(message)
      raise FailedAssertionError, message
    end

    def assert(condition, message = nil)
      message ||= I18n.t "neo.assertions.failed"
      flunk(message) unless condition
      true
    end

    def assert_equal(actual, expected, message = nil)
      message ||= I18n.t "neo.assertions.expected_to_equal",
        expected: expected.inspect,
        actual: actual.inspect

      assert(expected == actual, message)
    end

    def assert_not_equal(actual, expected, message = nil)
      message ||= I18n.t "neo.assertions.expected_to_not_equal",
        expected: expected.inspect,
        actual: actual.inspect

      assert(expected != actual, message)
    end

    def assert_nil(actual, message = nil)
      message ||= I18n.t "neo.assertions.expected_to_be_nil", actual: actual.inspect
      assert(nil == actual, message)
    end

    def assert_not_nil(actual, message = nil)
      message ||= I18n.t "neo.assertions.expected_to_not_be_nil", actual: actual.inspect
      assert(nil != actual, message)
    end

    def assert_match(actual, pattern, message = nil)
      message ||= I18n.t "neo.assertions.expected_to_match", actual: actual.inspect,
        pattern: pattern.inspect
      assert pattern =~ actual, message
    end

    def assert_raise(exception)
      begin
        yield
      rescue Exception => other
        expected = ex.is_a?(exception)
        message = I18n.t "neo.assertions.expected_to_raise_other",
          exception: exception.inspect,
          other: other.inspect
        assert expected, message
        return other
      end
      flunk I18n.t "neo.assertions.expected_to_raise", exception: exception.inspect
    end

    def assert_nothing_raised
      begin
        yield
      rescue Exception => exception
        flunk I18n.t "neo.assertions.expected_to_not_raise", exception: exception.inspect
      end
    end

  end
end
