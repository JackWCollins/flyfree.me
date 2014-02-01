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

	describe "#up_votes" do
		it "should return 1 when there is a single upvote" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			vote = Vote.create(video_id: video.id, user_id: alice.id, vote: true)
			expect(video.up_votes).to eq(1)
		end
		it "should return 3 when there are three upvotes" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: true)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			vote3 = Vote.create(video_id: video.id, user_id: charlie.id, vote: true)
			expect(video.up_votes).to eq(3)
		end
	end

	describe "#down_votes" do
		it "should return 1 when there is a single downvote" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			vote = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			expect(video.down_votes).to eq(1)
		end
		it "should return 3 when there are three downvotes" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: false)
			vote3 = Vote.create(video_id: video.id, user_id: charlie.id, vote: false)
			expect(video.down_votes).to eq(3)
		end
	end

	describe "#total_votes" do
		it "should return 0 when there are no votes" do
			video = Fabricate(:video)
			expect(video.total_votes).to eq(0)
		end
		it "should return 0 when there is one upvote and one downvote" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			expect(video.total_votes).to eq(0)
		end
		it "should return 1 when there is one downvote and two upvotes" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: true)
			vote3 = Vote.create(video_id: video.id, user_id: charlie.id, vote: true)
			expect(video.total_votes).to eq(1)
		end
		it "should return -1 when there is one upvote and two downvotes" do
			video = Fabricate(:video)
			alice = Fabricate(:user)
			bob = Fabricate(:user)
			charlie = Fabricate(:user)
			vote1 = Vote.create(video_id: video.id, user_id: alice.id, vote: false)
			vote2 = Vote.create(video_id: video.id, user_id: bob.id, vote: false)
			vote3 = Vote.create(video_id: video.id, user_id: charlie.id, vote: true)
			expect(video.total_votes).to eq(-1)
		end
	end
end