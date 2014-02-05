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

	describe "#get_thumbnail_url" do
		it "should return a thumbnail for YouTube videos" do
			alice = Fabricate(:user)
			youtube = Video.create(title: "Youtube Video", description: "A Youtube Video", url: "https://www.youtube.com/watch?v=pIZkgHMMSsM", user: alice)
			youtube.thumbnail_url = youtube.get_thumbnail_url
			expect(youtube.thumbnail_url).not_to be_nil
		end
		it "should return a thumbnail for Vimeo videos" do
			alice = Fabricate(:user)
			vimeo = Video.create(title: "Vimeo Video", description: "Vimeo Videos are cool", url: "http://vimeo.com/80168312", user: alice)
			vimeo.thumbnail_url = vimeo.get_thumbnail_url
			expect(vimeo.thumbnail_url).not_to be_nil
		end
	end

	describe "#total_votes" do
		it "should return 0 when there are no votes" do
			video = Fabricate(:video)
			expect(video.total_votes).to eq(0)
		end
		it "should return 1 when there is one vote" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			expect(video.total_votes).to eq(1)
		end
		it "should return 4 when there are 4 votes" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			dan = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			vote3 = Vote.create(video_id: video.id, user_id: charlie.id, vote: true)
			vote3 = Vote.create(video_id: video.id, user_id: dan.id, vote: true)
			expect(video.total_votes).to eq(4)
		end
	end
end