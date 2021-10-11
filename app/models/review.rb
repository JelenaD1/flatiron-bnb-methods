class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, :description, presence: true
  validate :existing_reservation_has_been_accepted_and_checkout_happened

  private
  

  def existing_reservation_has_been_accepted_and_checkout_happened
    if reservation.nil? || reservation.status != "accepted" || reservation.checkout > Time.now
      errors.add(:reservation, "is not accepted, or is still in progress")
    end
  end
end
