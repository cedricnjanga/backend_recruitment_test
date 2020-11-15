require 'rails_helper'

describe CreatePassengerRide, type: :interactor do
  let(:network) { Network.create(name: "Paris") }
  let(:user){ User.create(email: "david@email.com", network: network) }
  let(:ride){Ride.create(departure: "ici", arrival: "la", network: network) }

  describe '#call' do
    context 'when driver ride does not save' do
      it 'return data with errors' do
        result = CreatePassengerRide.call(
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
        result = CreatePassengerRide.call(
          network: network,
          options: {
            user_id: user.id,
            ride_id: ride.id
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
