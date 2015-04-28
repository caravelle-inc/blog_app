module UsersHelper

  def follow?(user)
    Friendship.find_by(to_user_id: user.id, from_user_id: current_user.id).nil?
  end
end
