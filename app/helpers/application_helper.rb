module ApplicationHelper
	def options_for_video_reviews(selected=nil)
		options_for_select([5,4,3,2,1].map{ |number| [pluralize(number, "Star"), number]}, selected)
	end

	def title(page_title)
		content_for(:title) { page_title }
	end
end
