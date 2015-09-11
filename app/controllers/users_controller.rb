class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :user_articles]
  before_action :authenticate_user!, only: [:destroy]

  def index
    if user_signed_in?
    @users = User.where.not(id: current_user.id )
    else
    @users = User.all
    end
  end

  def show
    @articles_new = Article.order('created_at DESC')
    @user_articles = @user.articles.order('created_at DESC')
  end

  def destroy
    if not_current_user?(current_user)
      flash[:alert] = "管理者以外は他のユーザを削除できません。"
      redirect_to admins_path
    end
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
