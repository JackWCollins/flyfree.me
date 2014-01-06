class Video < ActiveRecord::Base
  require 'video_info'

  validates_presence_of :title, :url, :description

  def embed_code
    video = VideoInfo.new(self.url)
    code = video.embed_code
    # if provider == "YouTube"
    #   code = '%iframe{:allowfullscreen => "allowfullscreen", :frameborder => "0", :src => "http://www.youtube.com/embed/#{video.video_id}"}'
    # elsif provider == "Vimeo"
    #   code = '%iframe{:allowfullscreen => "", :frameborder => "0", :height => "281", :mozallowfullscreen => "", :src => "//player.vimeo.com/video/#{video.video_id}", :webkitallowfullscreen => "", :width => "500"}'
    # else
    #   flash[:error] = "Video cannot be loaded. We apologize"
    # end
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