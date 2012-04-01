require 'rubygems'
require 'bundler/setup'

require 'rake'
require 'rspec/core/rake_task'
require 'appraisal'

desc 'Default: run unit tests.'
task :default => [:clean, :all]

desc "Run Specs against all Appraisals"
task :all => :spec do
  Rake::Task["appraisal:install"].execute
  system("bundle exec rake -s appraisal spec")
end

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

