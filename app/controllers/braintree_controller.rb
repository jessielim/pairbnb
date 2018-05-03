class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate
  	@reserve = Reservation.find(params[:id])
  	@user = current_user
    @listing_id = params[:listing_id]
	@this_reservation = @user.reservations.find_by(id: params[:id])
    
  end

	def checkout
		
	  # x = Listing.find(params[:listing_id])
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => "10.00", #this is currently hardcoded
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )
	  if result.success?
	    redirect_to :root, :flash => { :success => "Transaction successful!" }
	  else
	    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
	  end
	end

end
