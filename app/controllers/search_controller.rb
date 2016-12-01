class SearchController < ApplicationController

	def search
	  if params[:q].nil?
	    @listings = []
	  else
	    @listings = Listing.search params[:q]
	  end
	end
end