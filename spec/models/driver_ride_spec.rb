require 'rails_helper'

RSpec.describe DriverRide, type: :model do
  # Associations
  it { should have_one(:network).through(:user) }
  it { should belong_to(:user) }
  it { should belong_to(:ride) }
  it { should have_many(:passenger_rides) }
end
