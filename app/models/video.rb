class Video < ActiveRecord::Base
  require 'video_info'

  belongs_to :user
  has_many :reviews
  has_many :votes

  validates_presence_of :title, :url, :description
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 1000 }

  self.per_page = 24

  scope :featured, -> { where(featured: true) }

  def video_id
  	video = VideoInfo.new(self.url)
  	id = video.video_id
  end

  def get_thumbnail_url
  	video = VideoInfo.new(self.url)
  	provider = video.provider
  	if provider == "YouTube"
  	  thumbnail = video.thumbnail_medium
  	elsif provider == "Vimeo"
  	  thumbnail = video.thumbnail_large
  	end
  end

  def video_provider
    video = VideoInfo.new(self.url)
    provider = video.provider
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end