class AddForeignKeyToArticles < ActiveRecord::Migration
  def change
    add_foreign_key :articles, :users, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
  end
end