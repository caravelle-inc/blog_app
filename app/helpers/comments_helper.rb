module CommentsHelper
  def comment_owner?(comment)
    current_user == comment.user
  end
end
