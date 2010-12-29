require "spec_helper"

describe ValidatesLengthsFromDatabase do

  LONG_ATTRIBUTES = {
    :string_1 => "123456789",
    :string_2 => "123456789",
    :text_1 => "123456789",
    :date_1 => Date.today,
    :integer_1 => 123
  }

  SHORT_ATTRIBUTES = {
    :string_1 => "12",
    :string_2 => "12",
    :text_1 => "12",
    :date_1 => Date.today,
    :integer_1 => 123
  }

  context "Model with validates_lengths_from_database" do
    before do
      class ArticleValidateAll < ActiveRecord::Base
        set_table_name "articles"
        validates_lengths_from_database
      end
    end

    context "an article with overloaded attributes" do
      before { @article = ArticleValidateAll.new(LONG_ATTRIBUTES); @article.valid? }

      it "should not be valid" do
        @article.should_not be_valid
      end

      it "should have errors on all string/text attributes" do
        @article.errors["string_1"].join.should =~ /too long/
        @article.errors["string_2"].join.should =~ /too long/
        @article.errors["text_1"].join.should =~ /too long/
      end
    end

    context "an article with short attributes" do
      before { @article = ArticleValidateAll.new(SHORT_ATTRIBUTES); @article.valid? }

      it "should be valid" do
        @article.should be_valid
      end
    end
  end
  
  context "Model with validates_lengths_from_database :only => [:string_1, :text_1]" do
    before do
      class ArticleValidateOnly < ActiveRecord::Base
        set_table_name "articles"
        validates_lengths_from_database :only => [:string_1, :text_1]
      end
    end

    context "an article with long attributes" do
      before { @article = ArticleValidateOnly.new(LONG_ATTRIBUTES); @article.valid? }

      it "should not be valid" do
        @article.should_not be_valid
      end

      it "should have errors on only string_1 and text_1" do
        @article.errors["string_1"].join.should =~ /too long/
        @article.errors["string_2"].should be_empty
        @article.errors["text_1"].join.should =~ /too long/
      end
    end

    context "an article with short attributes" do
      before { @article = ArticleValidateOnly.new(SHORT_ATTRIBUTES); @article.valid? }

      it "should be valid" do
        @article.should be_valid
      end
    end
  end

  context "Model with validates_lengths_from_database :except => [:string_1, :text_1]" do
    before do
      class ArticleValidateExcept < ActiveRecord::Base
        set_table_name "articles"
        validates_lengths_from_database :except => [:string_1, :text_1]
      end
    end

    context "an article with long attributes" do
      before { @article = ArticleValidateExcept.new(LONG_ATTRIBUTES); @article.valid? }

      it "should not be valid" do
        @article.should_not be_valid
      end

      it "should have errors on columns other than string_1 and text_1 only" do
        @article.errors["string_1"].should be_empty
        @article.errors["text_1"].should be_empty
        @article.errors["string_2"].join.should =~ /too long/
      end
    end

    context "an article with short attributes" do
      before { @article = ArticleValidateOnly.new(SHORT_ATTRIBUTES); @article.valid? }

      it "should be valid" do
        @article.should be_valid
      end
    end
  end
  
end
