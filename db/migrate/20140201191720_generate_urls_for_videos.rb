class GenerateUrlsForVideos < ActiveRecord::Migration
  def change
  	Video.all.each do |video|
  		url = video.get_thumbnail_url
  		video.update_column(:thumbnail_url, url)
  	end
  end
end
