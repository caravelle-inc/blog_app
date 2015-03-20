class CreateFavoriteArticles < ActiveRecord::Migration
  def change
    create_table :favorite_articles do |t|
      t.references :user, index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
