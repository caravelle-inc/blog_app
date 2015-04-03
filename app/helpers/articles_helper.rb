module ArticlesHelper

  def favorite_article?(article)
    FavoriteArticle.find_by(article_id: article.id, user_id: current_user.id).nil?
  end
end
