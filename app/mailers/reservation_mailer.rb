class ReservationMailer < ApplicationMailer

	def booking_email(tenant, host, reservation_id)

		@tenant = tenant
		@host = host
		@reservation_id = reservation_id
		mail(to: @tenant.email, subject:"Booking Confirmed")

	end

end
