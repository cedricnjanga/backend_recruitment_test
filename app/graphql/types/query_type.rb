module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false, description: "A list of users scoped to a network"
    field :rides, [Types::RideType], null: false, description: "A list of rides scoped to a network"
    field :driver_rides, [Types::DriverRideType], null: false, description: "A list of driver rides scoped to a network"
    field :passenger_rides, [Types::PassengerRideType], null: false, description: "A list of passenger rides scoped to a network"
  end
end
