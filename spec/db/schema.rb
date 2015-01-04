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

