class AdminsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @users = User.all
    @articles = Article.all
  end
end
