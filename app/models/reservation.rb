require 'pry'
class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, :checkout, presence: true
  validate :guest_and_host_are_not_the_same_person
  validate :listing_availiable_before_making_reservation
  validate :checkout_date_after_checkin_date
  validate :checkin_and_checkot_dates_are_not_same
 

  def duration
    checkout - checkin
  end 

  def total_price
    duration * listing.price
  end 

  
  
  private

  def guest_and_host_are_not_the_same_person
    if guest == listing.host
      errors.add(:guest, "Who are you?")
    end 
  end 


  def checkout_date_after_checkin_date
    return if checkin.nil? || checkout.nil?
      if checkout < checkin
      errors.add(:checkout, "must be after the start date")
    end
  end 
  

  def listing_availiable_before_making_reservation
    return if checkin.nil? || checkout.nil? 
    if listing.neighborhood.neighborhood_openings(checkin.to_s, checkout.to_s).exclude?(listing)
    errors.add(:base, "Dates are not available") 
    end 
  end 

  def checkin_and_checkot_dates_are_not_same
    return if checkin.nil? || checkout.nil? 
    if checkin == checkout
      errors.add(:base, "Dates can not be the same")
    end   
  end    

end 
 






