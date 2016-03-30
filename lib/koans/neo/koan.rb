module Neo
  class Koan

    include Assertions

    attr_reader :name, :failure, :koan_count, :step_count, :koan_file

    def initialize(name, koan_file=nil, koan_count=0, step_count=0)
      @name = name
      @failure = nil
      @koan_count = koan_count
      @step_count = step_count
      @koan_file = koan_file
    end

    def passed?
      @failure.nil?
    end

    def failed(failure)
      @failure = failure
    end

    def setup
    end

    def teardown
    end

    def meditate
      setup
      begin
        send(name)
      rescue StandardError, Neo::Sensei::FailedAssertionError => ex
        failed(ex)
      ensure
        begin
          teardown
        rescue StandardError, Neo::Sensei::FailedAssertionError => ex
          failed(ex) if passed?
        end
      end
      self
    end

    # Class methods for the Neo test suite.
    class << self
      attr_accessor :test_pattern

      def inherited(subclass)
        subclasses << subclass
      end

      def method_added(name)
        testmethods << name if !tests_disabled? && Koan.test_pattern =~ name.to_s
      end

      def end_of_enlightenment
        @tests_disabled = true
      end

      # Lazy initialize list of subclasses
      def subclasses
        @subclasses ||= []
      end

       # Lazy initialize list of test methods.
      def testmethods
        @test_methods ||= []
      end

      def tests_disabled?
        @tests_disabled ||= false
      end

      def total_tests
        self.subclasses.inject(0){|total, k| total + k.testmethods.size }
      end

    end
  end
end
