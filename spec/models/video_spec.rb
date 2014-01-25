require 'spec_helper'

describe Video do
	it { should have_many(:votes) }
	
	describe "video_provider" do
		it "should return YouTube for a youtube url" do
		  youtube = Video.create(title: "Youtube Video", description: "A Youtube Video", url: "https://www.youtube.com/watch?v=pIZkgHMMSsM")
		  expect(youtube.video_provider).to eq("YouTube")
		end
		it "should return Vimeo for a vimeo url" do
			vimeo = Video.create(title: "Vimeo Video", description: "Vimeo Videos are cool", url: "http://vimeo.com/80168312")
			expect(vimeo.video_provider).to eq("Vimeo")
		end
	end

	describe "thumbnail" do
		it "should return a thumbnail for YouTube videos" do
			youtube = Video.create(title: "Youtube Video", description: "A Youtube Video", url: "https://www.youtube.com/watch?v=pIZkgHMMSsM")
			expect(youtube.thumbnail).not_to be_nil
		end
		it "should return a thumbnail for Vimeo videos" do
			vimeo = Video.create(title: "Vimeo Video", description: "Vimeo Videos are cool", url: "http://vimeo.com/80168312")
			expect(vimeo.thumbnail).not_to be_nil
		end
	end
end