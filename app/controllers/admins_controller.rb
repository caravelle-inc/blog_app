class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
    @articles = Article.all
  end
end
