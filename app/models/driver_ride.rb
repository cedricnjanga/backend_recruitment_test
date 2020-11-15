class DriverRide < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :ride
  has_many :passenger_rides
  has_one :network, through: :user
end
