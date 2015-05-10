class FavoriteArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  def self.favorite_check?(article, current_user)
    self.find_by(article_id: article.id, user_id: current_user.id).nil?
  end

end



