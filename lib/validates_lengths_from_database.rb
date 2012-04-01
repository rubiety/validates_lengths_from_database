require "rubygems"
require "active_record"

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

      if options[:only]
        columns_to_validate = options[:only].map(&:to_s)
      else
        columns_to_validate = column_names.map(&:to_s)
        columns_to_validate -= options[:except].map(&:to_s) if options[:except]
      end

      columns_to_validate.each do |column|
        column_schema = columns.find {|c| c.name == column }
        next if column_schema.nil?
        next if ![:string, :text].include?(column_schema.type)
        
        column_limit = options[:limit][column_schema.type] || column_schema.limit
        next unless column_limit

        class_eval do
          validates_length_of column, :maximum => column_limit, :allow_blank => true
        end
      end

      nil
    end

  end

  module InstanceMethods
  end
end

require "validates_lengths_from_database/railtie"
