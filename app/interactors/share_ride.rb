class ShareRide
  include Interactor

  delegate :network, :passenger_ride_id, :options, to: :context

  def call
    passenger_ride = network.passenger_rides.find(passenger_ride_id)

    if passenger_ride.update(options)
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