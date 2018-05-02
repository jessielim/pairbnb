
class ListingsController < ApplicationController

	def index
		@listing = Listing.all
		if params[:search]
			@listing = Listing.search(params[:search]).order("created_at DESC")
		else
			@listing = Listing.all.order("created_at DESC")
		end
			
	end

	def new
		# @listing = Listing.new(name: params[:name], property_type: params[:property_type], room_number: params[:room_number], bed_number: params[:bed_number], guest_number: params[:guest_number], country: params[:country], state: params[:state], city: params[:city], zipcode: params[:zipcode], address: params[:address], price: params[:price], description: params[:description], user_id: current_user.id)
	end

	def create
		@user = current_user.id
  		@listing = Listing.create(listing_params)
  		
  		redirect_to root_path
  		
  	end

	def show
		@listing = Listing.find(params[:id])
		@reserve = Reservation.all
		
	end

	def edit
		@listing = Listing.find(params[:id])
		allowed?(action: "listing_edit", user: current_user)
	end

	def update
		@listing = Listing.find(params[:id])
  		if @listing.update(listing_params)
  			redirect_to root_path
  		else
  			render 'edit'
  		end
	end

	def destroy
		
	end

	def listing_params
  	params.require(:listing).permit(:name, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price,:description, :user_id, {images: []})
	end
	
end