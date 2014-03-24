require 'spec_helper'

feature "user signs in" do
	scenario "with valid username and password" do
		alice = Fabricate(:user)
		visit sign_in_path
		fill_in "Username", with: alice.username
		fill_in "Password", with: alice.password
		click_button "Sign in"

		page.should have_content alice.username

	end
end