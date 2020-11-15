module Mutations
  class CreatePassengerRideMutation < Mutations::BaseMutation
    description "A passenger requests a ride"

    argument :user_id, ID, "The id of the passenger", required: true
    argument :ride_id, ID, "The id of the ride", required: true

    field :passenger_ride, Types::PassengerRideType, "The created passenger ride", null: true
    field :errors, [String], "The list of errors if it failed. Empty if succeed.", null: true

    def resolve(**options)
      result = CreatePassengerRide.call(
        options: options,
        network: object
      )

      result.data
    end
  end
end
