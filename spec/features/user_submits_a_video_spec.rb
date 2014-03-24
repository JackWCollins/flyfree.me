require 'spec_helper'

feature "User submits a video" do
	scenario "User successfully submits a video" do
		alice = Fabricate(:user)
		visit sign_in_path
		fill_in "Username", with: alice.username
		fill_in "Password", with: alice.password
		click_button "Sign in"

		click_link "Submit"

		fill_in "Title", with: "HFTH Skydiving"
		fill_in "Url", with: "http://www.youtube.com/watch?v=ryOfZkI1L0w"
		fill_in "Description", with: "Super great skydiving video"
		click_button "Submit Video"

		visit video_path(Video.first)
		expect(page).to have_content "HFTH Skydiving"
		expect(page).to have_content "Submitted by #{alice.username}"

	end
end