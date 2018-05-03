class ReservationsController < ApplicationController
	def new
		@listing = Listing.find(params[:id])
		@rsvp = Reservation.new
	end

	def create
		@listing = Listing.find(params[:id])
		@rsvp = Reservation.new(reservation_params)
		@user = current_user
		
		if date_checker(@rsvp.start_date, @rsvp.end_date)
			@rsvp.save
			redirect_to "/braintree/#{@rsvp.id}"
		else
			redirect_to reservation_new_path
		end
		if @rsvp.save
  			ReservationJob.perform_later(@user,@listing,@rsvp)
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