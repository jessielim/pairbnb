class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate
  	@reserve = Reservation.find(params[:id])
  	@user = current_user
  end

	def checkout
		
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => @reserve.listing.price, #this is currently hardcoded
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
