require "factory_girl"

Factory.define(:article) do |f|
  f.title { Faker::Lorem.sentence }
  f.summary { Faker::Lorem.paragraphs.first }
  f.body { Faker::Lorem.paragraphs.join("\n\n") }
  f.post_date { 1.day.ago.to_date }
end

Factory.define(:article_draft, :class => Article::Draft) do |f|
  f.association(:article)
  f.title { Faker::Lorem.sentence }
  f.summary { Faker::Lorem.paragraphs.first }
  f.body { Faker::Lorem.paragraphs.join("\n\n") }
  f.post_date { 1.day.ago.to_date }
end

Factory.define(:article_with_draft, :parent => :article) do |f|
  f.association(:draft, :factory => :article_draft)
end
