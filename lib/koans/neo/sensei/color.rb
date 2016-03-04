module Neo
  class Sensei
    module Color
      #shamelessly stolen (and modified) from redgreen
      COLORS = {
        :clear   => 0,  :black   => 30, :red   => 31,
        :green   => 32, :yellow  => 33, :blue  => 34,
        :magenta => 35, :cyan    => 36,
      }

      module_function

      COLORS.each do |color, value|
        module_eval "def #{color}(string); colorize(string, #{value}); end"
        module_function color
      end

      def colorize(string, color_value)
        if use_colors?
          color(color_value) + string + color(COLORS[:clear])
        else
          string
        end
      end

      def color(color_value)
        "\e[#{color_value}m"
      end

      def use_colors?
        return false if ENV["NO_COLOR"]
        if ENV["ANSI_COLOR"].nil?
          if using_windows?
            using_win32console
          else
            return true
          end
        else
          ENV["ANSI_COLOR"] =~ /^(t|y)/i
        end
      end

      def using_windows?
        File::ALT_SEPARATOR
      end

      def using_win32console
        defined? Win32::Console
      end

    end
  end
end
