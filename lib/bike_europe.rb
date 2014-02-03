require 'debugger'
require_relative 'bike_europe/util'
require_relative 'bike_europe/city'
require_relative 'bike_europe/road'



class BikeEurope 
  attr_reader :visited_cities

  def initialize(start_city, end_city)
    @start_city, @end_city = start_city, end_city
    @current_city = start_city
    @visited_cities = [start_city]
  end

  def shortest_road_of_current_city
    roads = @current_city.roads
    roads_available = roads.reject{|road| !new_road?(road) }
    # here it choose the shortest path based on distance
    
    roads_available.min_by{|road| road.distance}
    # it output the shortest distance path
  end

  def new_road?(road)
    destination_city = road.the_city_opposite(@current_city)
   !@visited_cities.include?(destination_city)
  end

  def roads_left_behind
    # create an array with those cities left behind
    # when path was choosen (under shortest path condition)
    roads = @current_city.roads
    roads_left_behind = roads.reject{|road| !new_road?(road)}
    roads_left_behind.max_by{|road| road.distance}
  end

  
  def bike_on_road(road)
    destination_city = road.the_city_opposite(@current_city)
    @current_city = destination_city
    @visited_cities <<  @current_city
  end

  def results!
    until @current_city == @end_city

      shortest_road = self.shortest_road_of_current_city
      self.bike_on_road(shortest_road)
      p @current_city
    end
    @visited_cities
  end
  # Pseudocode
  # Finding Shortest distance:
    # going to each road
    # find the distance of each of them
    # sort it by the shortest to longest distance
    # return the road with the shortest distance 


  # Start with start_city
  # Select the shortest distance for the next city
  # continue doing loop
  # end when hits end_city

  # dont go backwards 


  # =============

end 



# >>>>>>>>>>>>>>>>>>>       From Original Code      <<<<<<<<<<<<<<<<<<<<<<<<<<<<

# Start = City::Rome
# End   = City::Berlin


# # Make a list of cities from Rome to Berlin
# result = visited_cities  (this is an array) # <-- your code goes here!!!!


# if result.first != Start || result.last != End
#   puts "Not done yet!"
#   puts "You need the 'result' variable to be a list of cities"
#   exit 1
# end
# total_distance = 0
# result.each_with_index do |city, idx|
#   print city
#   if next_city = result[idx+1]
#     distance = Road.between(city, next_city).distance
#     total_distance += distance
#     puts " -> #{"%.0f" % distance}"
#   end
# end
# print "arrived in #{result.size} steps "
# print "(#{"%.0f" % total_distance} km)"
# puts ""
# puts ""


# >>>>>>>>>>>>>>>>>>>>>>>>   Gaby's driver code    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Start = City::Rome
End   = City::Berlin

bike_ride = BikeEurope.new(Start, End)

p bike_ride.roads_left_behind

# p bike_ride.results!

