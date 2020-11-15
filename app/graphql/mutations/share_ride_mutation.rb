module Mutations
  class ShareRideMutation < Mutations::BaseMutation
    description "A passenger goes with a driver"

    argument :driver_ride_id, ID, "The id of the driver ride", required: true
    argument :passenger_ride_id, ID, "The id of the passenger ride", required: true

    field :passenger_ride, Types::PassengerRideType, "The updated passenger ride", null: true
    field :errors, [String], "The list of errors if it failed. Empty if succeed.", null: true

    def resolve(passenger_ride_id:, **options)
      result = ShareRide.call(
        options: options,
        passenger_ride_id: passenger_ride_id,
        network: object
      )
      
      result.data
    end
  end
end
