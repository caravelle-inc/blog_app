class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :user_articles]
  before_action :authenticate_user!, only: [:destroy]

  def index
    @users = User.all.reject { |user| user.id == current_user.id }
  end

  def show
    @articles_new = Article.order('created_at DESC')
    @user_articles = @user.articles.order('created_at DESC')
  end

  def destroy
    @user.destroy
    redirect_to admins_path
  end

  def user_articles
    @user_articles = @user.articles.order('created_at DESC')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end