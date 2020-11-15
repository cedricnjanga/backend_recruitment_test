class Ride < ApplicationRecord
  # Associations
  belongs_to :network
  has_many :driver_rides
  has_many :passenger_rides

  # Validations
  validates_presence_of :departure, :arrival

  # Scopes
  scope :by_network, ->(network) { where(network: network) }
end
