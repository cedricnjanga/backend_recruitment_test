module Mutations
  class CreateDriverRideMutation < Mutations::BaseMutation
    description "A driver declares he will drive trhough a ride"

    argument :user_id, ID, "The id of the driver", required: true
    argument :ride_id, ID, "The id of the ride", required: true

    field :driver_ride, Types::DriverRideType, "The created driver ride", null: true
    field :errors, [String], "The list of errors if it failed. Empty if succeed.", null: true

    def resolve(**options)
      result = CreateDriverRide.call(
        options: options,
        network: object
      )

      result.data
    end
  end
end
