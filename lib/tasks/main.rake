PROB_DIR   = "koans"
TEMPLATES  = FileList.new ["lib/templates/*.erb"]
KOAN_FILES = TEMPLATES.pathmap("#{PROB_DIR}/%f")

task default: :run

desc "Run the path to enlightenment"
task :run do
  cd PROB_DIR
  ruby FileList['00_*'].first
end

directory PROB_DIR

desc "Regenerate koans directory and files"
task regenerate: %i{ clobber generate }

desc "Generate koans directory and files"
task generate: KOAN_FILES

desc "Clobber generated koans directory"
task :clobber do
  rm_r PROB_DIR
end

TEMPLATES.each do |koan_src|
  file koan_src.pathmap("#{PROB_DIR}/%f") => [PROB_DIR, koan_src] do |t|
    Koans.make_koan_file koan_src, t.name
  end
end
