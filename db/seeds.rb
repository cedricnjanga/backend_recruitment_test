# We flush the DB
PassengerRide.delete_all
DriverRide.delete_all
Ride.delete_all
User.delete_all
Network.delete_all

#Create networks
toulouse_network = Network.create!(name: "Toulouse")
paris_network = Network.create!(name: "Paris")

# We start by creating some rides,
# These are the available routes our users will be able to use
toulouse_intra = Ride.create!(departure: "Cite de l'espace", arrival: "Capitole", network: toulouse_network)
toulouse_navette = Ride.create!(departure: "Capitole", arrival: "Aeroport", network: toulouse_network)
paris_intra = Ride.create!(departure: "Louvre", arrival: "Nation", network: paris_network)
paris_suburb = Ride.create!(departure: "Clichy", arrival: "Louvre", network: paris_network)

[toulouse_network, paris_network].each do |network|
  suffix = "+#{network.name.downcase}"

  # Now, some users have signed up to our platform
  # David, with a "D" as in "Driver"
  david = User.create!(email: "david#{suffix}@email.com", network: network)

  # Patrice, with a "P" as in "Passenger"
  patrice = User.create!(email: "patrice#{suffix}@email.com", network: network)

  # Peter, with a "P" as in "Passenger"
  peter = User.create!(email: "peter#{suffix}@email.com", network: network)

  # Next, our users start to use our transport service
  # David inform us that he will drive his car on the toulouse_intra route
  david_ride = DriverRide.create!(user: david, ride: network.rides.first)

  # And at the same time, Patrice made a passenger request on the same route
  patrice_ride = PassengerRide.create!(user: patrice, ride: network.rides.first)

  # So both of them meet, and David invites Patrice to share the ride
  patrice_ride.update!(driver_ride: david_ride)

  # At the last time, Peter also make a request for the same route
  peter_ride = PassengerRide.create!(user: peter, ride: network.rides.first)

  # So David can also take him in his car, he now has two passenger, and his car is almost full.
  # So much co2 saved compared to if the three of them had used their own car
  peter_ride.update!(driver_ride: david_ride)
end
