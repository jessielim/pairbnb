class ReservationMailer < ApplicationMailer

 
  def confirmation_email(user,listing,reservation_id)
    @user = user
    @rsvp_id = reservation_id
    @listing = listing
    @url  = 'localhost:3000/listings/:id/reservations/new'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
