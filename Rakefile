require 'bundler/gem_tasks'
require 'rake/testtask'

desc "Run the tests"
task :test do
  Rake::TestTask.new do |t|
    t.libs << "spec"
    t.pattern = "spec/*_spec.rb"
  end
end
