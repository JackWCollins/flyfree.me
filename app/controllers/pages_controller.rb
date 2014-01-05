class PagesController < ApplicationController

  def index
  	@videos = Video.all
  end

end