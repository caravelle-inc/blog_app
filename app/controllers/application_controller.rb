class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
  before_action :set_recent_articles

  private

  def set_recent_articles
    @recent_articles = Article.order('created_at DESC').limit(10)
  end

end

