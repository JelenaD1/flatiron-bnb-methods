class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  has_many :guests, through: :reviews, :foreign_key => 'host_id'
  
  

  # as a host, knows about the guests its had (FAILED - 3)
  # as a guest, knows about the hosts its had (FAILED - 4)
  # as a host, knows about its reviews from guests (FAILED - 5)

  

  
  
end
