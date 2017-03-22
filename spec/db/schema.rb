ActiveRecord::Schema.define(:version => 0) do
  create_table :articles, :force => true do |t|
    t.string :string_1, :limit => 5
    t.string :string_2, :limit => 5

    if postgresql?
      # PostgreSQL doesn't support limits on text columns
      t.text :text_1
    else
      t.text :text_1, :limit => 5
    end

    t.date :date_1
  
    t.integer :integer_1, :limit => 5
    t.decimal :decimal_1, :precision => 5, :scale => 2
    t.float :float_1, :limit => 5

    if database_supports_arrays?
      t.string :array_1, :array => true, :limit => 5
    end
  end

  create_table :articles_high_limit, :force => true do |t|
    t.string :string_1
    t.string :string_2
    t.text :text_1
    t.date :date_1
    t.integer :integer_1
    t.decimal :decimal_1, :precision => 11, :scale => 2
    t.float :float_1

    if database_supports_arrays?
      t.string :array_1, :array => true
    end
  end
end

