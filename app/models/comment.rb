class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :comment,
            length: { minimum: 3, message: "3文字以上入力してください" }

  def comment_owner?(current_user)
    current_user == self.user
  end

end
