class Friendship < ActiveRecord::Base
  belongs_to :from_user, :class_name => 'User'
  belongs_to :to_user, :class_name => 'User'

  def self.follow?(user, current_user)
    self.find_by(to_user_id: user.id, from_user_id: current_user.id).nil?
  end

end
