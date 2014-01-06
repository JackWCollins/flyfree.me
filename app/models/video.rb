class Video < ActiveRecord::Base
  require 'video_info'

  validates_presence_of :title, :url, :description

  def embed_code
    gem_video = VideoInfo.new(self.url)
    code = gem_video.embed_code
  end

  def video_id
  	gem_video = VideoInfo.new(self.url)
  	id = gem_video.video_id
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
    gem_video = VideoInfo.new(self.url)
    provider = gem_video.provider
  end
end