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
    # An array of roads 
    # roads = @current_city.roads
    # # An array of roads available which is:
    # #   all roads except the "not" new roads:
    # roads_available = roads.reject{|road| !new_road?(road) }
    # here I choose the shortest path based on distance
    # debugger
    self.roads_available.min_by{|road| road.distance}
    # it output the shortest distance path
  end

  def new_road?(road)
    destination_city = road.the_city_opposite(@current_city)
   !@visited_cities.include?(destination_city)
  end

  def roads_left_behind
    # output all the roads left behind
    # when path was choosen (under shortest path condition)
    roads = @current_city.roads
    # An array of all the roads left behind
    roads_left_behind = roads.reject{|road| new_road?(road)}
  end

  def roads_available
    roads = @current_city.roads
    roads_available = roads.reject{|road| !new_road?(road) }
  end

  
  def bike_on_road(road)
    destination_city = road.the_city_opposite(@current_city)
    @current_city = destination_city
    @visited_cities <<  @current_city
  end

  def results!
    until @current_city == @end_city
      # Road object:
      shortest_road = self.shortest_road_of_current_city
      roads_left = self.roads_left_behind
      only_road = self.roads_available[0]
#     if only road available, bike_on_road
      if self.roads_available.length == 1
          self.bike_on_road(only_road)
    # if the shortest road is not one of the roads left behind, then bike on road
      else
        if shortest_road!= roads_left
        self.bike_on_road(only_road)  
        end    
      end

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
# >> New w/exeption << :  if only road available, bike_on_road
# else
  # Select the shortest distance for the next city
  # continue doing loop
  # end when hits end_city

# >>>>>>>>>>>>EXCEPTION<<<<<<<<<<<<
  # dont go backwards:
    # bike on road to shortest road but dont bike to roads left 


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

# p bike_ride.roads_left_behind
# p bike_ride.shortest_road_of_current_city
# p bike_ride.roads_available

p bike_ride.results!

