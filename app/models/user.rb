class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :follow_user, :class_name => 'Friendship', :foreign_key => 'from_user_id', :dependent => :destroy
  has_many :follower_user, :class_name => 'Friendship', :foreign_key => 'to_user_id', :dependent => :destroy
  has_many :follow, :through => :follow_user, :source => 'to_user'
  has_many :follower, :through => :follower_user, :source => 'from_user'
  has_many :articles, :dependent => :destroy
  has_many :favorite_article, :dependent => :destroy

  mount_uploader :image, ImageUploader


  #rails consoleでNameError: uninitialized constant User::ImageUploaderに対して
  require 'carrierwave/orm/activerecord'

end