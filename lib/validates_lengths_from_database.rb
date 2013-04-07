require "rubygems"
require "active_record"
require "validates_lengths_from_database/all_columns_length_validator"

module ValidatesLengthsFromDatabase
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def validates_lengths_from_database(options = {})
      options.symbolize_keys!

      return false unless self.table_exists?
      
      options[:only]    = Array[options[:only]]   if options[:only] && !options[:only].is_a?(Array)
      options[:except]  = Array[options[:except]] if options[:except] && !options[:except].is_a?(Array)
      options[:limit] ||= {}

      if options[:limit] and !options[:limit].is_a?(Hash)
        options[:limit] = {:string => options[:limit], :text => options[:limit]}
      end

      validator = AllColumnsLengthValidator.new(self, options.merge(:allow_blank => true))
      
      validate validator

      nil
    end

  end

  module InstanceMethods
  end
end

require "validates_lengths_from_database/railtie"
