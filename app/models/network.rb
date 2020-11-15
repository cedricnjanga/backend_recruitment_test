class Network < ApplicationRecord
  has_many :users
  has_many :rides
  has_many :driver_rides, through: :rides
  has_many :passenger_rides, through: :rides

  validates_presence_of :name
  validates_uniqueness_of :name
end
