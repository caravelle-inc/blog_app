class UsersController < ApplicationController

  before_action :set_user, only: [:show, :destroy, :follow, :follow_list, :follower_list, :my_articles]

  def index
    @users = User.all
    @articles_new = Article.order('id DESC')
  end

  def show
    @articles_new = Article.order('id DESC')
    @user_articles = User.find(params[:id]).articles
  end

  def destroy
    @user.delete
    @follow_from = Friendship.where(:from_user_id => params[:id])
    @follow_to = Friendship.where(:to_user_id => params[:id])
    if @follow_from.present?
      @follow_from.delete
    end
    if @follow_to.present?
      @follow_to.delete
    end
    redirect_to admins_path
  end

  def follow
    @follow = Friendship.new
    @follow.from_user_id = current_user.id
    @follow.to_user_id = @user.id
    @follow.save
    redirect_to users_path
  end

  def follow_destroy
    @follow = Friendship.find_by(:to_user_id => params[:id])
    @follow.delete
    redirect_to users_path
  end

  def follow_list

  end

  def follower_list

  end

  def my_articles
    @user_articles = @user.articles
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
