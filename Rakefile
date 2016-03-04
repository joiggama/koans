require "i18n"

I18n.load_path      = Dir["lib/locales/*.yml"]
I18n.default_locale = ENV["LOCALE"] || :en

task :default do
  Rake::Task["koans:generate"].invoke if Dir["koans"].empty?
  Rake::Task["koans:run"].invoke
end

task gen: "koans:generate"
task regen: "koans:regenerate"
task run: "koans:run"

namespace :gem do
  require "bundler/gem_tasks"
end

namespace :koans do
  Dir.glob("lib/tasks/*.rake").each { |r| load r}
end
