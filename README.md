##Bike to Europe:##
This is a graph traversal problem that I am solving using Ruby

![image](https://s3-us-west-1.amazonaws.com/bikeeurope/europemap.jpg)

###Status###
Final draft but need refactoring code to make it cleaner

  Current Status:

  Input

      Start = City::Rome

      End   = City::Berlin

       bike_ride = BikeEurope.new(Start, End)

 Output 

   bike_ride.results!

   (As seen in terminal...)

    bike_europe [master] :> ruby lib/bike_europe.rb

[Rome, Torino, Lyon, Paris, Antwerp, Hamburg, Berlin]


## Rector Code Updates ###

### Adding Logic based on order:  

 + First: Ignore all the roads that go to a city that we visited
 + Second: Ignore all the roads that go to cities that we left behind (missed cities)
 + Third and Finally: Pick the road with the shortest distance 