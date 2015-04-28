class RenameMovieColumnToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :movie, :youtube_url
  end
end
