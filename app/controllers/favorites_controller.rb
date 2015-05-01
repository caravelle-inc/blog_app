class FavoritesController < ApplicationController

  def index
    @favorites = FavoriteArticle.where(:user_id => current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @my_favorites = FavoriteArticle.where(:user_id => @user.id)
  end

  def add
    @favorite = FavoriteArticle.new
    @favorite.user_id = current_user.id
    @favorite.article_id = params[:id]
    @favorite.save
    redirect_to(:back)
  end

  def destroy
    @favorite = FavoriteArticle.find_by(article_id: params[:id], user_id: current_user.id)
    @favorite.destroy
    redirect_to(:back)
  end

  private

  # def favorite_params
  #   params[:article].permit(:user_id, )
  # end

end
