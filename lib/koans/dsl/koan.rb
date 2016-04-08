module Koans
  module DSL
    class Koan

      TEMPLATE = File.read(File.expand_path("../../../templates/base/koan.erb", __FILE__))

      attr_reader :name, :tests

      def initialize(name, &block)
        @name = name
        @tests = []
        instance_eval(&block)
      end

      def render
        ERB.new(TEMPLATE, nil, "-").result(binding)
      end

      def test(test_name, &block)
        @tests << Test.new(@name, test_name, &block)
      end

      def translate(key)
        I18n.t("tests.#{@name}.#{key}")
      end

    end
  end
end
