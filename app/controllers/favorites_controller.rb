class FavoritesController < ApplicationController

  before_action :set_article, only:[:favorite]
  before_action :authenticate_user!

  def favorite
    @favorite_article = FavoriteArticle.new
    @favorite_article.user_id = current_user.id
    @favorite_article.article_id = @article.id
    @favorite_article.save
    flash[:notice] = "お気に入りに追加しました。"
    redirect_to(:back)
  end

  def favorite_list
    @favorite_list = FavoriteArticle.where(:user_id => current_user.id)
  end

  def my_favorites
    @user = User.find(params[:format])
    @my_favorites = FavoriteArticle.where(:user_id => @user.id)
  end

  def destroy
    @favorite = FavoriteArticle.find_by(article_id: params[:id], user_id: current_user.id)
    @favorite.destroy
    flash[:alert] = "お気に入りを削除しました。"
    redirect_to(:back)
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

end
