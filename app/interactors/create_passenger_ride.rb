class CreatePassengerRide
  include Interactor
  include NetworkSupport
  include RideSupport

  delegate :network, :options, to: :context

  def call
    passenger_ride = ride.passenger_rides.build(options)

    if passenger_ride.save
      context.data = {
        passenger_ride: passenger_ride,
        errors: []
      }
    else
      context.data = {
        passenger_ride: nil,
        errors: passenger_ride.errors.full_messages
      }
    
      context.fail!
    end
  rescue
    context.data = {
      errors: ["See logs for details"]
    }
    context.fail!
  end
end