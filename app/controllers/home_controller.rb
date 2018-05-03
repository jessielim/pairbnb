class HomeController < ApplicationController
	def index
		@user = User.all.limit(10)
		@listing = Listing.order(:name).page(params[:page])
	end
end