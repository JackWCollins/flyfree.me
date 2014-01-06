class Video < ActiveRecord::Base
  require 'video_info'

  validates_presence_of :title, :url, :description

  def embed_code
    video = VideoInfo.new(self.url)
    code = video.embed_code
  end

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