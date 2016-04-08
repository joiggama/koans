require "koans"

task :default do
  Rake::Task["koans:generate"].invoke if Dir["koans"].empty?
  Rake::Task["koans:run"].invoke
end

task del: "koans:clobber"
task gen: "koans:generate"
task reg: "koans:regenerate"
task run: "koans:run"

namespace :gem do
  require "bundler/gem_tasks"
end

namespace :koans do
  Dir.glob("lib/tasks/*.rake").each { |r| load r }
end
