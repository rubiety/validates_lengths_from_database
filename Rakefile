require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

desc 'Default: run unit tests.'
task :default => [:clean, :test]

desc "Run Specs"
RSpec::Core::RakeTask.new(:spec) do |t|
end

task :test => :spec

desc "Clean up files."
task :clean do |t|
  FileUtils.rm_rf "tmp"
  Dir.glob("spec/db/*.sqlite3").each {|f| FileUtils.rm f }
  Dir.glob("validates_lengths_from_database-*.gem").each {|f| FileUtils.rm f }
end

