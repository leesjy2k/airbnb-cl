class Reservation < ActiveRecord::Base

	belongs_to :listing
	belongs_to :user

	def calculate_price
		price_per_night = self.listing.price
		duration = (self.check_out - self.check_in).to_i
		self.total_price = price_per_night * duration
		self.save!
	end

	def overlaps?(other_reservation)
    	(self.checkin - other_reservation.checkout) * (other_reservation.checkin - self.checkout) >= 0
  	end

  	def paid!
	    self.paid = true
	    self.save!
	end

	def paid?
	    self.paid
	end
end
