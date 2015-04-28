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
    # @user.delete
    # @follow_from = Friendship.where(:from_user_id => params[:id])
    # @follow_to = Friendship.where(:to_user_id => params[:id])
    # if @follow_from.present?
    #   @follow_from.delete
    # end
    # if @follow_to.present?
    #   @follow_to.delete
    # end
    redirect_to admins_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
