class Video < ActiveRecord::Base
  require 'video_info'

  belongs_to :user
  has_many :reviews

  validates_presence_of :title, :url, :description
  validates :title, length: { maximum: 100 }

  def video_id
  	video = VideoInfo.new(self.url)
  	id = video.video_id
  end

  def thumbnail
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
end