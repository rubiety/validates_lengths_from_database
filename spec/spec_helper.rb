require "rubygems"
require "rspec"
require "active_record"

# Establish DB Connection
config = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'db', 'database.yml')))
ActiveRecord::Base.configurations = {'test' => config[ENV['DB'] || 'sqlite3']}
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])

def postgresql?
   ActiveRecord::Base.connection.instance_values["config"][:adapter] == 'postgresql'
 end

# Load Test Schema into the Database
load(File.dirname(__FILE__) + "/db/schema.rb")

require File.dirname(__FILE__) + '/../init'
