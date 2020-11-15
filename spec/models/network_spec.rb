require 'rails_helper'

RSpec.describe Network, type: :model do
  # Associations
  it { should have_many(:users) }
  it { should have_many(:rides) }
  it { should have_many(:driver_rides).through(:rides) }
  it { should have_many(:passenger_rides).through(:rides) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
