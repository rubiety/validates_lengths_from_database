# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validates_lengths_from_database/version"

Gem::Specification.new do |s|
  s.name        = "validates_lengths_from_database_advanced"
  s.version     = ValidatesLengthsFromDatabase::VERSION
  s.author      = "Ben Hughes"
  s.email       = "ben@railsgarden.com"
  s.homepage    = "http://github.com/robinbortlik/validates_lengths_from_database"
  s.summary     = "Automatic maximum-length validations."
  s.description = "Introspects your database string field maximum lengths and automatically defines length validations."

  s.files        = Dir["{lib,spec,rails}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"
  
  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
  
  s.add_dependency("activerecord", [">= 2.3.2"])
  s.add_development_dependency("rspec", ["~> 2.0"])
  s.add_development_dependency("sqlite3-ruby", ["~> 1.3.1"])
end

