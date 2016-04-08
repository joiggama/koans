require "erb"
require "i18n"
require "koans/dsl"
require "koans/neo"
require "koans/version"

I18n.load_path      = Dir["#{File.expand_path("../", __FILE__)}/locales/*.yml"]
I18n.default_locale = ENV["LOCALE"] || :en

module Koans
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
    outfile = "koans/#{file_number}_" + I18n.t("tests.#{file_name}.filename")

    template = File.read(infile)
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

    File.write(outfile, content)
  end

end
