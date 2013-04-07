module ValidatesLengthsFromDatabase
  class AllColumnsLengthValidator < ActiveModel::EachValidator
    
    def initialize(model, options)
      @model = model
      super options.merge(:attributes => [:bogus])
    end
    
    def attributes
      columns.keys
    end
    
    def validate_each(record, attribute, value)
      validator = ActiveModel::Validations::LengthValidator.new(:attributes => [attribute], :maximum => columns[attribute])
      validator.validate_each(record, attribute, value)
    end
    
    def columns
      if options[:only]
        columns_to_validate = options[:only].map(&:to_s)
      else
        columns_to_validate = @model.column_names.map(&:to_s)
        columns_to_validate -= options[:except].map(&:to_s) if options[:except]
      end
      
      columns_to_validate.inject({}) do |all, column|
        column_schema = @model.columns.find {|c| c.name == column }
        if !column_schema.nil? && [:string, :text].include?(column_schema.type)
          if column_limit = options[:limit][column_schema.type] || column_schema.limit
            all.merge!(column.to_sym => column_limit)
          end
        end
        
        all
      end
    end
    
  end
end