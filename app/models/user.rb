class User < ActiveRecord::Base
	has_many :videos, -> { order("created_at DESC") }
	has_many :reviews
	has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
	has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id
  has_many :votes

  validates_presence_of :email, :password, :username
  validates_uniqueness_of :email, :username

  has_secure_password validations: false

  before_create :generate_token

  def follows?(another_user)
  	following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  def recent_videos
    videos.first(6)
  end

  def can_feature?(video)
    !!(self.admin? && !(video.featured?))
  end

  def user_votes
    user_votes = 0
    self.videos.each { |vid| user_votes += vid.total_votes}
    user_votes
  end
end