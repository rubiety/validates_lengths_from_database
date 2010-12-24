ActiveRecord::Schema.define(:version => 0) do
  
  [:articles, :article_drafts].each do |table_name|
    create_table table_name, :force => true do |t|
      t.references :article if table_name == :article_drafts
      
      t.string :title
      t.text :summary
      t.text :body
      t.date :post_date
    end
  end
  
end