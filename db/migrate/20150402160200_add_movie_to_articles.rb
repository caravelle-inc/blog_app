class AddMovieToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :movie, :string
  end
end
