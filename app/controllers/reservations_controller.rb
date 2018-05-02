class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:id])
		@rsvp = Reservation.new
	end

	def create
		@listing = Listing.find(params[:id])
		@rsvp = Reservation.new(reservation_params)
		
		if date_checker(@rsvp.start_date, @rsvp.end_date)
			@rsvp.save

  			ReservationMailer.confirmation_email(current_user,@listing,@rsvp).deliver_now
			redirect_to braintree_new_path
		else
			redirect_to reservation_new_path
		end

	end

	def show
		@rsvp = Reservation.all
	end

	def date_checker(start_date,end_date)
		@reservation = Reservation.where("listing_id = ?" , params[:id])
		if @reservation
			
			@reservation.each do |r|
				
				if 	!(r.end_date <= start_date || r.start_date >= end_date)
						flash[:notice] ="Sorry, dates has been taken."
					return false
				end
			end
		else
			return true
		end
	end

	def reservation_params
  	  	params.require(:reservation).permit(:user_id, :listing_id, :guest_number, :verification, :start_date, :end_date)
	end
end