class CreateDriverRide
  include Interactor
  include NetworkSupport
  include RideSupport

  delegate :network, :options, to: :context

  def call
    driver_ride = ride.driver_rides.build(options)

    if driver_ride.save
      context.data = {
        driver_ride: driver_ride,
        errors: []
      }
    else
      context.data = {
        driver_ride: nil,
        errors: driver_ride.errors.full_messages
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