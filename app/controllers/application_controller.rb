class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
  before_action :set_articles_new

  private

  def set_articles_new
    @articles_new = Article.order('created_at DESC').limit(10)
  end

end

