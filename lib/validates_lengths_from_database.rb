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

      raise ArgumentError, "The :only option to validates_lengths_from_database must be an array." if options[:only] and !options[:only].is_a?(Array)
      raise ArgumentError, "The :except option to validates_lengths_from_database must be an array." if options[:except] and !options[:except].is_a?(Array)

      if options[:only]
        columns_to_validate = options[:only].map(&:to_s)
      else
        columns_to_validate = column_names.map(&:to_s)
        columns_to_validate -= options[:except].map(&:to_s) if options[:except]
      end

      columns_to_validate.each do |column|
        column_schema = columns.find {|c| c.name == column }
        column_limit = options[:limit].try(:[], column_schema.type) || column_schema.limit
        next if column_schema.nil?
        next if ![:string, :text].include?(column_schema.type)
        next if column_limit.nil?

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
