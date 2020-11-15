require 'rails_helper'

RSpec.describe Ride, type: :model do
  # Associations
  it { should belong_to(:network) }
  it { should have_many(:driver_rides) }
  it { should have_many(:passenger_rides) }

  # Validations
  it { should validate_presence_of(:departure) }
  it { should validate_presence_of(:arrival) }
end
