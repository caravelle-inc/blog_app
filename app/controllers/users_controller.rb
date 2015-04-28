class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :follow, :follow_list, :follower_list]

  def index
    @users = User.all
    @articles_new = Article.order('created_at DESC')
  end

  def show
    @articles_new = Article.order('created_at DESC')
    @user_articles = @user.articles.order('created_at DESC')
  end

  def destroy
    @user.destroy
    redirect_to admins_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
