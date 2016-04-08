directory Koans::OUTPUT_DIR

desc "Clobber generated koans directory"
task :clobber do
  rm_r Koans::OUTPUT_DIR
end

desc "Generate koans directory and files"
task generate: Koans::OUTPUT_FILES

desc "Regenerate koans directory and files"
task regenerate: %i{ clobber generate }

desc "Run the path to enlightenment"
task :run do
  cd Koans::OUTPUT_DIR
  ruby FileList['00_*'].first
end

Koans::INPUT_FILES.each do |koan_src|
  file koan_src.pathmap("#{Koans::OUTPUT_DIR}/%f") => [Koans::OUTPUT_DIR, koan_src] do |t|
    Koans.make_koan_file(koan_src, t.name)
  end
end
