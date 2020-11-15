module RideSupport
  extend ActiveSupport::Concern

  included do
    delegate :ride, to: :context

    before :check_ride
  end

  private

  def check_ride
    # byebug
    context.ride = network.rides.find(options[:ride_id])

  rescue ActiveRecord::RecordNotFound => e
    context.data = {
      errors: ["ride_id is required"]
    }
    context.fail!
  end
end