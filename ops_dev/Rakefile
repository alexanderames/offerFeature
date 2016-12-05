# frozen_string_literal: true
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/unit/*_test.rb']
  t.warning = false
end

RuboCop::RakeTask.new

desc 'Run serverspec tests against $TARGET_HOST and $TARGET_PORT'
RSpec::Core::RakeTask.new(:serverspec) do |t|
  t.pattern = 'test/integration/*_spec.rb'
end

task default: [:rubocop, :test, :serverspec]
