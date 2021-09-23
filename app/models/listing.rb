class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, :listing_type, :description, :title, :price, :neighborhood_id, presence: true

  after_create :convert_host_to_true
  after_destroy :convert_back_to_user


  def average_review_rating
    reviews.average(:rating)
  end 


 private  

  def convert_host_to_true
     host.update(:host => true)
  end 

  # Whenever a listing is destroyed (new callback! Google it!) the user attached to that listing should be converted back to a regular user. 
  # That means setting the host field to false.

   def convert_back_to_user
    if host.listings.empty?
    host.update(:host => false)
    end 
   end 
  
  

 
  
end
