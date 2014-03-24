require 'spec_helper'

feature "User Registers" do
	scenario "with valid information" do
		visit register_path
		fill_in "Email", with: "vertstreet@comcast.net"
		fill_in "Password", with: "password"
		fill_in "Username", with: "vertstreet"

		click_button "Register!"

		expect(page).to have_content "vertstreet"
		expect(page).not_to have_content "Sign In"
	end
end