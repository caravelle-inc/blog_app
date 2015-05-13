class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :to_user, :class_name => 'Friendship', :foreign_key => 'from_user_id', :dependent => :destroy
  has_many :from_user, :class_name => 'Friendship', :foreign_key => 'to_user_id', :dependent => :destroy
  has_many :follow_user, :through => :to_user, :source => 'to_user'
  has_many :follower_user, :through => :from_user, :source => 'from_user'
  has_many :articles, :dependent => :destroy
  has_many :favorite_article, :dependent => :destroy
  has_many :friendships

  mount_uploader :image, ImageUploader

  require 'carrierwave/orm/activerecord'

  def current_user?(current_user)
    self.id == current_user.id
  end

  def not_current_user?(current_user)
    self.id != current_user.id
  end

  def follow?(current_user)
    Friendship.find_by(to_user_id: self.id, from_user_id: current_user.id).nil?
  end

end