class HomeController < ApplicationController
	def index
		@listings = Listing.paginate(:page => params[:page], :per_page => 6).order('created_at DESC')  
	end 
end
