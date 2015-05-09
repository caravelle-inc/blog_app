class ApplicationController < ActionController::Base

  before_action :set_recent_articles

  private

  def set_recent_articles
    @recent_articles = Article.order('created_at DESC').limit(10)
  end

end
