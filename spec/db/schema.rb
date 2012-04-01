ActiveRecord::Schema.define(:version => 0) do
  
  create_table :articles, :force => true do |t|
    t.string :string_1, :limit => 5
    t.string :string_2, :limit => 5
    t.text :text_1, :limit => 5
    t.date :date_1
    t.integer :integer_1
  end
  
  create_table :articles_high_limit, :force => true do |t|
    t.string :string_1
    t.string :string_2
    t.text :text_1
    t.date :date_1
    t.integer :integer_1
  end
  
end
