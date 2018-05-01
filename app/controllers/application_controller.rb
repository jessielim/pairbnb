class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def allowed?(action:, user:)
  	case action
  	when "listing_edit"

    if current_user.id != @listing.user_id
  		flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to "/", notice: "Sorry. You do not have the permission to view a property."
    return false
    
    end

    when "listing_verify"

    if current_user.role != "moderator"
      flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to "/", notice: "Sorry. You do not have the permission to view a property."
    return false
    end
  end
  end
  		
  		
  		
end
