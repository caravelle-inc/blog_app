class UsersController < ApplicationController

  def index
    @users = User.all
    @articles_pn = Article.all
  end

  def show
    @user = User.find(params[:id])
    @articles_pn = Article.all
    @user_articles = User.find(params[:id]).article
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    @follow_from = Friendship.where(:from_user_id => params[:id])
    @follow_to = Friendship.where(:to_user_id => params[:id])
    @follow_from.delete
    @follow_to.delete
    redirect_to admins_path
  end

  def follow
    @follow = Friendship.new
    @follow.from_user_id = current_user.id
    @user = User.find(params[:id])
    @follow.to_user_id = @user.id
    @follow.save
    redirect_to users_path
  end

  def follow_destroy
    @follow = Friendship.where(:to_user_id => params[:id])
    @follow.each do |a|
      a.delete
    end
    redirect_to users_path
  end

end


