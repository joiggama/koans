module Neo
  class ThePath

    def walk
      sensei = Neo::Sensei.new
      each_step do |s|
        sensei.observe(s.meditate)
      end
      sensei.instruct
    end

    def each_step
      catch(:neo_exit) do
        step_count = 0

        Neo::Koan.subclasses.each_with_index do |koan, koan_index|

          koan.testmethods.each do |method_name|
            s = koan.new(method_name, koan.to_s, koan_index + 1, step_count += 1)
            yield s
          end

        end

      end
    end

  end
end
