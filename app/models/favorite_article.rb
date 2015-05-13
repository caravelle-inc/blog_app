class FavoriteArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  def favorite_user(current_user)
    current_user == self.user
  end

end

