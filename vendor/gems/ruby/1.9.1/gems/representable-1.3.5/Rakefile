require 'bundler/setup'
require 'rake/testtask'

desc 'Test the representable gem.'
task :default => :test

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/*_test.rb']
  test.verbose = true
end

Rake::TestTask.new(:test18) do |test|
  test.libs << 'test'
  test.test_files = FileList['test/*_test.rb'] - ['test/mongoid_test.rb', 'test/yaml_test.rb']
  test.verbose = true
end