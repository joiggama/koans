module Koans
  module DSL
    class Test

      attr_reader :koan, :name

      def initialize(koan, name, &block)
        @koan    = koan
        @name    = name
        @source  = ""
        instance_eval(&block)
      end

      def has?(attribute)
        I18n.exists?("tests.#{@koan}.#{@name}.#{attribute}")
      end

      def source(content = nil)
        content ?  @source << format(content) : @source
      end

      def translate(key)
        I18n.t("tests.#{@koan}.#{@name}.#{key}")
      end

      private

      def format(content)
        return content if content.empty?

        formatted    = []
        unformatted  = content.lines
        left_padding = count_leading_spaces(unformatted.first)
        formatted   << unformatted.shift.strip

        unformatted.each do |line|
          extra_padding = count_leading_spaces(line) - left_padding
          formatted << case
                       when extra_padding.zero?
                         (" " * (left_padding - 2)) << line.strip
                       when extra_padding > 0
                         (" " * (left_padding + extra_padding)) << line.strip
                       end
        end

        formatted.join("\n")
      end

      def count_leading_spaces(line)
        line[/\A */].length
      end

    end
  end
end
