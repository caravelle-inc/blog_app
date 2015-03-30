class AdminsController < ApplicationController
  def index
    @users = User.all
    @articles = Article.all
  end

  # def show
  #   @admin = Admin.find(params[:id])
  # end
  #
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.delete
  #   redirect_to admins_path
  # end
end
