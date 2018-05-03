class ReservationJob < ApplicationJob
  queue_as :default

  
  def perform(user,listing,reservation_id)
    ReservationMailer.confirmation_email(user,listing,reservation_id).deliver_now
  end
end
