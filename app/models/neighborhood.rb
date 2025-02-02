class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings


  def neighborhood_openings(start_date, end_date)
    city_listings = self.listings
    city_reservations = city_listings.filter do |listing| 
      listing.reservations.none? do |reservation|
        reservation.checkin <= end_date.to_datetime && start_date.to_datetime <= reservation.checkout
      end 
    end 
  end 

  def self.highest_ratio_res_to_listings
    all.max_by {|city| city.listings.count}
  end 


  def self.most_res
    all.max_by {|city| city.reservations.count}
  end 

end
