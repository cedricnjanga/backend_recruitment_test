require 'rails_helper'

RSpec.describe PassengerRide, type: :model do
  # Associations
  it { should have_one(:network).through(:user) }
  it { should belong_to(:user) }
  it { should belong_to(:ride) }
  it { should belong_to(:driver_ride).optional }
end
