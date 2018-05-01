class HomeController < ApplicationController
	def index
		@user = User.all.last(10)
		# @listing = Listing.paginate(:page => params[:page], :per_page => 9)

		@listing = Listing.order(:name).page(params[:page])
	end
end