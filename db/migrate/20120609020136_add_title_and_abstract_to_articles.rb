class AddTitleAndAbstractToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string
    add_column :articles, :abstract, :text
  end
end
