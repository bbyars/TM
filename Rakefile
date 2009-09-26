require 'rake'
require 'rake/testtask'

task :default => "test:unit"

Rake::TestTask.new("test:unit") do |t|
  t.test_files = FileList['test/**/*_test.rb']
end
Rake::Task["test:unit"].comment = "run unit tests"
