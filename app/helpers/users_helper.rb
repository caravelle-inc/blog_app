module UsersHelper

  def follow?(user)
    # Friendship.where(:to_user_id => user.id).present? && Friendship.where(:from_user_id => current_user.id).present?
    Friendship.find_by(to_user_id: user.id, from_user_id: current_user.id).nil?
  end
end
