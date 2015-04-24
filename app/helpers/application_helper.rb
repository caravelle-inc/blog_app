module ApplicationHelper

  def article_owner?(article)
    current_user == article.user
  end

  def comment_owner?(comment)
    current_user == comment.user
  end
end
