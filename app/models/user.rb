class User < ActiveRecord::Base
	has_many :videos
	has_many :reviews
	has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
	has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  validates_presence_of :email, :password, :username
  validates_uniqueness_of :email

  has_secure_password validations: false
end