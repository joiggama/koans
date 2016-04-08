require "erb"
require "i18n"
require "rake"

require "koans/dsl"
require "koans/neo"
require "koans/version"

I18n.load_path      = Dir["#{File.expand_path("../", __FILE__)}/locales/**/*.yml"]
I18n.default_locale = ENV["LOCALE"] || :en

module Koans
  INPUT_FILES  = Rake::FileList.new ["lib/templates/*.{erb,rb}"]
  OUTPUT_DIR   = "koans"
  OUTPUT_FILES = INPUT_FILES.pathmap("#{OUTPUT_DIR}/%f")

  extend Rake::DSL if defined?(Rake::DSL)

  # Remove solution info from source
  #   __(a,b)     => __
  #   _n_(number) => __
  #   # __        =>
  def self.remove_solution(line)
    line = line.gsub(/\b____\([^\)]+\)/, "____")
    line = line.gsub(/\b___\([^\)]+\)/, "___")
    line = line.gsub(/\b__\([^\)]+\)/, "__")
    line = line.gsub(/\b_n_\([^\)]+\)/, "_n_")
    line = line.gsub(%r(/\#\{__\}/), "/__/")
    line = line.gsub(/\s*#\s*__\s*$/, '')
    line
  end

  def self.make_koan_file(infile, outfile)
    file_number, file_name = *infile.pathmap("%n").split(/(\d+)_/).last(2)

    outfile = "#{OUTPUT_DIR}/#{file_number}_" + I18n.t("tests.#{file_name}.filename")

    template = File.read(infile)

    if infile.end_with?(".erb")
      lines = ERB.new(template, nil, "-").result(binding).split("\n")
      content = ""

      state = :copy
      lines.each do |line|
        state = :skip if line =~ /^ *#--/
        if state == :copy
          content << remove_solution(line) << "\n"
        end
        state = :copy if line =~ /^ *#\+\+/
      end
    else
      content = eval(template)
    end

    File.write(outfile, content)
  end

  def self.define(name, &block)
    Koans::DSL::Koan.new(name, &block).render
  end

end
