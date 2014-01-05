class Video < ActiveRecord::Base
  validates_presence_of :title, :url, :description

  def self.yt_video_id
  	regex = /youtube.com.*(?:\/|v=)([^&$]+)/
    video.url.match(regex)
  end
end