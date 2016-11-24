class ListingsController < ApplicationController

	def index # display all listings

	end

	def show # display a specific listing
		@listing = Listing.find
	end

	def new # load the form to create a new listing
	end

	def create #saving the new listing in the database

	end

	def edit # load the edit form
	end

	def update # update the listing into the database
	end

	def delete # delete the listing
	end

end
