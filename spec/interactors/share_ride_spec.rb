require 'rails_helper'

describe ShareRide, type: :interactor do
  let(:network) { Network.create(name: "Paris") }
  let(:driver){ User.create(email: "david@email.com", network: network) }
  let(:passenger){User.create(email: "peter@email.com", network: network)}
  let(:ride){Ride.create(departure: "ici", arrival: "la", network: network) }
  let(:passenger_ride) { PassengerRide.create(network: network, user: passenger, ride: ride)}
  let(:driver_ride) { DriverRide.create(network: network, user: driver, ride: ride)}

  describe '#call' do
    context 'when driver ride does not save' do
      it 'return data with errors' do
        result = ShareRide.call(
          network: network,
          options: {}
        )

        expect(result.success?).to be_falsey
        expect(result.data).to be
        expect(result.data[:passenger_ride]).to be_nil
        expect(result.data[:errors]).to be
      end
    end

    context 'when driver ride saves' do
      it 'should return a result with a driver ride instance' do
        result = ShareRide.call(
          network: network,
          passenger_ride_id: passenger_ride.id,
          options: {
            driver_ride: driver_ride
          }
        )

        expect(result.success?).to be_truthy
        expect(result.data).to be
        expect(result.data[:passenger_ride]).to be
        expect(result.data[:errors]).to be_empty
      end
    end
  end
end
