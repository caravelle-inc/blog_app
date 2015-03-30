class AddForeignKeyToFavoriteArticles < ActiveRecord::Migration
  def change
    add_foreign_key :favorite_articles, :articles, options: 'ON UPDATE CASCADE ON DELETE CASCADE'
  end
end
