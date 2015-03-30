module ArticlesHelper

  def favorite_article?(article)
    FavoriteArticle.where(:article_id => article.id).present? && FavoriteArticle.where(:user_id => current_user.id).present?
  end
end
