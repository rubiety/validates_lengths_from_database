require "rubygems"
require "rspec"
require "active_record"
require "active_support"
require "yaml"

# Establish DB Connection
config = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'db', 'database.yml')))
ActiveRecord::Base.configurations = {'test' => config[ENV['DB'] || 'sqlite3']}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])

def database_supports_arrays?
  postgresql? && active_record_4?
end

def postgresql?
  ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgresql'
end

def active_record_4?
  ActiveRecord::VERSION::MAJOR >= 4
end

# Load Test Schema into the Database
load(File.dirname(__FILE__) + "/db/schema.rb")

require File.dirname(__FILE__) + '/../init'
