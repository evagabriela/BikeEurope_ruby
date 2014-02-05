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
    @destinations_left_behind = []
  end


  # we are at a current city, about to bike on 'road'
  def bike_on_road(road)
    
    @destinations_left_behind += missed_destinations(road)
    puts "missed destinations:", @destinations_left_behind
    destination_city = road.the_city_opposite(@current_city)

    # we have arrived at the city now
    @current_city = destination_city

    @visited_cities <<  @current_city

  end

  def pick_road
    all_roads = @current_city.roads
    puts "all choices", all_roads
      # Ignore all the roads that go to a city that we visited
      all_roads.delete_if{|road| goes_to_visited_city?(road) }
      puts "after ignoring visited cities:", all_roads
      # Ignore all the roads that go to cities that we left behind (missed cities)
      all_roads.delete_if{|road| goes_to_missed_cities?(road)}
      puts "after ignoring missed cities", all_roads
      all_roads.min_by{|road| road.distance}

  end

  def results!
    # LOOP
    # current city
    # pick_road
    # bike(road)
    until @current_city == @end_city
      puts "current city:", @current_city
      road = pick_road
      puts "choice:", road
      bike_on_road(road)
    end
    @visited_cities
  end

  private

  # def shortest_road_of_current_city
  #   self.roads_available.min_by{|road| road.distance}
  # end

  def goes_to_missed_cities?(road)
    destination = road.the_city_opposite(@current_city)
    @destinations_left_behind.include?(destination)
  end

  def goes_to_visited_city?(road)
    destination = road.the_city_opposite(@current_city)
    @visited_cities.include?(destination)
  end

  # the missed destinations for current city
  def missed_destinations(chosen_road)
    # An array of all the roads left behind
    roads_left_behind = roads_available.reject {|road| road == chosen_road }
    # collect the destination left behind with those roads 
    roads_left_behind.map { |road| road.the_city_opposite(@current_city)}

  end

  def roads_available
    roads = @current_city.roads
    roads_available = roads.reject{|road| goes_to_visited_city?(road) }
  end


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

