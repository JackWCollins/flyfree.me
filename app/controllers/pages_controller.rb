class PagesController < ApplicationController

  def index
  	@videos = Video.order(created_at: :desc).page(params[:page])
  end

  def about
  end

  def contact
  end
end