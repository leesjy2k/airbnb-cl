class ReservationsController < ApplicationController

 def create
    # insert authorize here
    unless current_user.tenant?
      redirect_to url_root
    end
    listing = Listing.find(params[:listing_id])
    if listing.nil?
      redirect_to root_url
    end
    reservation = listing.reservations.new(reservation_params)
    reservation.user = current_user
    reservation.calculate_price
    if reservation.save
      # ReservationJob.perform_later(current_user, listing.user, reservation.id)
      # ReservationMailer.booking_email(current_user, listing.user, reservation.id).deliver_later
      redirect_to listings_path(listing), notice: 'reservation succeeded'
    else
      redirect_to listings_path(listing), notice: 'reservation failed'
    end
  end


 # def create
 #  	if !current_user.nil?
	#   	@listing = Listing.find(params[:listing_id])
	#   	@reservation = Reservation.new
	#   	reservation = Reservation.new(reservation_params)
	#   	reservation.user_id = current_user.id
	#   	reservation.listing_id = params[:listing_id]
	  	
	#   	if !@listing.reservations.all.empty?
	# 	  	@listing.reservations.all.each do |other|
		  	
	# 	  		if reservation.overlaps?(other)
	# 	  			redirect_to listings_path, notice: "Date unavailable." && return
	# 	  		end
	# 	  	end
	# 	  end
	  	
	#   	if reservation.save
	#   		# ReservationJob.perform_later(current_user, @listing.user, reservation.id)
	# 	  	redirect_to @listing, notice: "Success!"
	# 	  else
	# 		  redirect_to @listing, notice: "Unable to book a reservation."
	# 		end
	# 	else
	# 		redirect_to sign_in_path, notice: "Please sign in to continue."
	# 	end
 #  end

  def show
    @reservation = Reservation.find(params[:id])
    if @reservation.nil? || @reservation.user != current_user
      redirect_to root_url
    end

    gon.client_token = Braintree::ClientToken.generate
  end

  def pay
    @reservation = Reservation.find(params[:id])
    if @reservation.nil? || @reservation.user != current_user
      redirect_to root_url
    end

    nonce_from_the_client = params[:payment_method_nonce]

    result = Braintree::Transaction.sale(
      :amount => @reservation.total_price,
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )
    if result.success?
      @reservation.paid!
      redirect_to root_url, notice: 'Payment succeed!'
    else
      redirect_to @reservation, notice: 'Payment failure!'
    end
  end


	private

		def reservation_params
			params.require(:reservation).permit(:check_in, :check_out, :user_id, :listing_id)



		end
end
