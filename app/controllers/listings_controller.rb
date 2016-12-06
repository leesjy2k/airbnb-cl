class ListingsController < ApplicationController

	def index # display all listings
		page = params[:page]
	    page ||= 1

	    query = params[:query]
	    query ||= ""

	    # @index = Listing.text_search(query).page(page).per(10)
	    @index = Listing.text_search(query)
	    @index = @index.price_min(params[:price_min]) if params[:price_min].present? 
	    @index = @index.price_max(params[:price_max]) if params[:price_max].present?
	    @index = @index.limit_location(params[:limit_location]) if params[:limit_location].present?
	    @index = @index.page(page).per(10)
	end

	def show # display a specific listing
		@listing = Listing.find(params[:id])
	end

	def new # load the form to create a new listing
		if current_user
			@listing = Listing.new
		else
			redirect_to sign_in_path, notice: "Please sign in to continue" and return
		end
	end

	def create #saving the new listing in the database
		@listing = current_user.listings.new(listing_params)
		if @listing.save 
			redirect_to @listing, notice: "Listing created."
		else 
			render 'new'
		end
	end

	def edit # load the edit form
		@listing = Listing.find(params[:id])
	end

	def update # update the listing into the database
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
			redirect_to @listing, notice: "Success!"
		else
			render 'edit'
		end
	end

	def destroy # delete the listing
		Listing.find(params[:id]).destroy
    	flash[:success] = "Listing deleted"
    	redirect_to listings_path
	end

	def price_range
		@listings = Listing.where(location: params[:location])
		
		params[:from] = "0" if params[:from] == ""
		params[:to] = "10000" if params[:to] == ""
		
		@listings = @listings.where("price >= ? and price <= ?", params[:from], params[:to]).paginate(:page => params[:page], :per_page => 6).order('price ASC')

		respond_to do |format|
		  format.js
		end
	end

	# def new
	# 	if user.tenant?
	# 		flash[:notice] = "Sorry. You are not allowed to perform this action as a tenant."
	# 		return redirect_to sign_in_path "Sorry. You cannot list a property as a tenant."
	# 	else
	# 		@listing = Listing.new
	# 	end

	private

		def listing_params
			params[:listing][:location].downcase!
			params.require(:listing).permit(:title, :description, :home_type, :location, :guest, :bedroom, :price, {photos: []}, :tag_list, :breakfast)
		end
end


