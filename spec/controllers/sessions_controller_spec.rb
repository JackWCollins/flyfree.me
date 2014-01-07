require 'spec_helper'

describe SessionsController do
  describe "GET new" do

  	it "renders the new template for unauthenticated users" do 
  		get :new
  		expect(response).to render_template :new
  	end

  	it "redirects to the root path for authenticated users" do
  		session[:user_id] = Fabricate(:user).id
  		get :new
  		expect(response).to redirect_to root_path
  	end

  end
  describe "POST create" do
  	let (:alice) { Fabricate(:user) }

  	context "with valid credentials" do
  	  before { post :create, username: alice.username, password: alice.password }

	  	it "sets the user id in the session" do
	  		expect(session[:user_id]).to eq(alice.id)
	  	end

	  	it "redirects to the root path" do
	  		expect(response).to redirect_to root_path
	  	end

	  	it "sets the notice" do
	  		expect(flash[:notice]).not_to be_blank
	  	end
	  end

	  context "with invalid credentials" do
	    before { post :create, username: alice.username, password: alice.password + 'asdfasdf' }

	  	it "does not put the user id in the session" do
	  		expect(session[:user_id]).to be_nil
	  	end

	  	it "redirects to the sign in page" do
	  		expect(response).to redirect_to sign_in_path
	  	end

	  	it "sets the error message" do
	  		expect(flash[:error]).not_to be_blank
	  	end
	  end
  end
  describe "GET destroy" do
  	before { session[:user_id] = Fabricate(:user).id }

  	it "removes the user id from the session" do
  		get :destroy
  		expect(session[:user_id]).to be_nil
  	end

  	it "redirects to the root path" do
  		get :destroy
  		expect(response).to redirect_to root_path
  	end

  	it "sets the notice" do
  		get :destroy
  		expect(flash[:notice]).not_to be_blank
  	end
  end
end