class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy]
  before_action :authenticate_user!, only: [:destroy]

  def index
    @users = User.all
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