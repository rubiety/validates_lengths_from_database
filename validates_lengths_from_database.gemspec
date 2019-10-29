# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "validates_lengths_from_database/version"

Gem::Specification.new do |s|
  s.name        = "validates_lengths_from_database"
  s.version     = ValidatesLengthsFromDatabase::VERSION
  s.author      = "Ben Hughes"
  s.email       = "ben@railsgarden.com"
  s.homepage    = "http://github.com/rubiety/validates_lengths_from_database"
  s.summary     = "Automatic maximum-length validations."
  s.description = "Introspects your database string field maximum lengths and automatically defines length validations."

  s.files        = Dir["{lib,spec,rails}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
  s.required_ruby_version = ">= 2.4"

  s.add_dependency("activerecord", [">= 4"])
  s.add_development_dependency("activesupport", [">= 4"])
  s.add_development_dependency("rspec", ["~> 2.0"])
  s.add_development_dependency("sqlite3", ["~> 1.3.4"])
  s.add_development_dependency("appraisal", ["~> 1.0.2"])
  s.add_development_dependency("pg", ["~> 0.17.1"])
  s.add_development_dependency("rdoc", ["~> 3.12"])

  # rspec 2 relies rake < 11 for the `last_comment` method
  # https://stackoverflow.com/a/35893625
  s.add_development_dependency("rake", ["< 11"])

  # I'm not sure why this isn't installed along with activesupport,
  # but for whatever reason running `bundle install` doesn't install
  # i18n so I'm adding it here for now.
  # https://github.com/rails/rails/blob/master/activesupport/activesupport.gemspec#L19 ?
  s.add_development_dependency("i18n")
  s.add_development_dependency("iconv", "~> 1.0.4")
end

