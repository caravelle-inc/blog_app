module FavoritesHelper

  def favorite_user(favorite)
      current_user == favorite.user
  end
end
