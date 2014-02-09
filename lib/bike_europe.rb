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

# >>>>>>>>>>>>>>>>>>>>>>        Dijkstra's algorithm    <<<<<<<<<<<<<<<<<<<<<<<<<<<<

# Let the node at which we are starting be called the initial node.

  # Start = City::Rome => initial node 

# Let the distance of node Y be the distance from the initial node to Y.

  # the distance of city Y (any city), be the distance from Rome to city Y
  # Other important notes:  The distance between cities are not unique and the distance depends on the road that we take 

# Dijkstra's algorithm will assign some initial distance values and will
# try to improve them step by step:
  # improving means to find the shortest distance 

# 1. Assign to every node a tentative distance value: set it to zero for our initial node and to infinity for all other nodes.
      # Set initial distance value of zero for our start city (Rome) and infinite distance for all other cities (Y)
      INFINITY = 9999999999
      Start = City::Rome
   

      # result = {
      #   :city_destination => [city, city ]
      # }
      other_cities = City.all.delete(Start) 


      
      # distance_from_start_hash contains our distance (which was provided) from a given city to start
      # this distance is our best guess at the shortest distance
      # { Rome => 0,
      #   Torino => 200,
      #   Milan => INFINITY }
      #  Usage:
      # the distance from Paris to Start (Rome)
      # distance_from_start_hash[Paris]  # => 200
      distance_from_start_hash = {}
      result = {}

      distance_from_start_hash[Start] = 0
      result[Start] = [Start]
      # city = key
      # distance = value 
      other_cities.each { |city| distance_from_start_hash[city] = INFINITY  }
      other_cities.each {|city| result[city] = []}

      # SUMMARY:  WE ARE SETTING ALL THE CITIES DISTANCES EXPECT THE START CITY TO HAVE INFINITE DISTANCE

# 2. Mark all nodes unvisited. Set the initial node as current. Create a set of the unvisited nodes called the unvisited set 
#   consisting of all the nodes.
      # Set all cities unvisited. 
      # the initial city is equal to the current_city
      # create a list with all the unvisited cities
      # was_city_visited = {
      #   :torino => false
      #   :milan => false
      # }

     # was_city_visited[torino] = true

      was_city_visited = {}
      City.all.each{|city| was_city_visited[city] = false}
   
      current_city = Start

      unvisited_cities = []

      was_city_visited.each do |city, visited|
        if !visited
          unvisited_cities << city
        end
      end

      # SUMMARY: WE ARE SETTING IF WE VISITED THE CITY OR NOT AND DEFINING CURRECT CITY  AND CREATE THE UNVISITED CITY LIST 


# 3. For the current node, consider all of its unvisited neighbors and calculate their tentative distances. For example, 
#   if the current node A is marked with a distance of 6, and the edge connecting it with a neighbor B has length 2, 
#   then the distance to B (through A) will be 6 + 2 = 8.
  
      # For the current city, consider all the unvisited neighbor cities
      # Calculate their tentative distances of the current city to the unvisited neighbor cities based on the shortest one between current city and the unvisited citites (ex. if the distance
        # is infinite then replace that with 200km )
      current_city 
      neighbor_cities 
      unvisited_neighbor_cities
      distance_from_start_hash
      neighbor_cities = current_city.adjacent_cities
      # unvisited_neighbor_cities = unvisited_cities.select{|unvisited_city| neighbor_cities.include?(unvisited_city) }
      unvisited_neighbor_cities = neighbor_cities & unvisited_cities

      distance_from_start_hash[Start] = 0

        # go thourgh all the unvisited neighbor cities (array) 
        # Find the distance From current city to those unvisited neighbor citiees
        # replace the distance_from_start_hash values for the shortest distance that is found for it 
        unvisited_neighbor_cities.each do |city|
          distance_from_current_city_to_neighbor_city = city.kilometers_to(current_city)

          distance_from_start_to_neighbor_city = distance_from_current_city_to_neighbor_city + distance_from_start_hash[current_city]

          if distance_from_current_city_to_neighbor_city < distance_from_start_hash[city]
            distance_from_start_hash[city] = distance_from_current_city_to_neighbor_city 

            results[city] << current_city  #a hash with everything except the city itself, ex if you ask for the path of berlin it gives you everything except berlin
          end

        end

    # SUMMARY:  WE ARE SETTING UP THE DISTANCES BETWEEN THE START CITY AND THE UNVISITED NEIGHBOR CITIES.
              # IF WE FIND THAT THE DISTANCE BETWEEN THE START CITY AND THE NEIGHBOOR UNVISITED CITY IS LESS THAN THE CURRENT DISTANCE CITY set there THEN WE 
              # REPLACE it

                # CALCULATE THE OPTIONS


# 4.When we are done considering all of the neighbors of the current node, mark the current node as visited and remove it 
  # from the unvisited set.   
  # A visited node will never be checked again.

    # mark the current city as visited city and take it out from the unvisited city list 

  current_city
  unvisited_cities
  was_city_visited
 
  was_city_visited[current_city] = true

  unvisited_cities.reject!{|unvisited_city| current_city == unvisited_city}

  # SUMMARY:  WHEN I CALCULATE THE DISTANCE BETWEEN THE CURRENT CITY AND NEIGHBOR CITIES THEN MARK THE CURRENT CITY AS VISITED CITY AND THEN TAKE THE 
  # VISITED CITY OUT FROM THE UNVISITED CITIES LIST 
      # WHEN YOU ALREADY CALCULLATED THE OPTIONS, MARK CURRENT CITY AS VISITED CITY

# 5. If the destination node has been marked visited (when planning a route between two specific nodes) or if the smallest 
#   tentative distance among the nodes in the unvisited set is infinity (when planning a complete traversal; occurs when
#   there is no connection between the initial node and remaining unvisited nodes), then stop. The algorithm has finished.

  destination_city 
  was_city_visited
  route_plan
  distance_from_start_hash
  unvisited_cities

  destination_city = unvisited_city_min_distance

  unvisited_city_min_distance = unvisited_cities.min_by do |city|
                                  distance_from_start_hash[city]
                                end

  if !unvisited_cities.include?(destination_city) || distance_from_start_hash[unvisited_city_min_distance]== INFINITE
    # return distance_from_start_hash[end_city ]
    return results[end_city].push end_city
  end

  p results 


# SUMMARY:  IF ALL THE DESTINATION Was VISITED OR THE DESTINATIONS HAVE DISTANCE BETWEN THEM AS INFINITE (WHICH MEANS THAT WE NEVER VISITED) THEN 
#           THEN WE STOP => WHICH MEANS THAT WE VISITED EVERYTHING AND NOW WE HAVE OUR HASH WITH ALL THE INFORMATION WE NEED WHICH IS THE SHORTEST
#           DISTANCES

#           Do all of this until you visited all cities except the ones that are outise of the road path 

# 6. Select the unvisited node that is marked with the smallest tentative distance, and set it as the new "current node" then 
  # go back to step 3.

  # FROM ALL THE UNVISITED CITIES, FIND THE ONE WITH THE SMALLEST DISTANCE 
  # MAKE THAT "ONE"  AS THE CURRENT CITY
  # GO BACK TO STEP 3

  unvisited_city_min_distance
  unvisited_cities
  distance_from_start_hash
  current_city

  if unvisited_city_min_distance !== nil

    unvisited_city_min_distance = unvisited_cities.min_by do |city|
                                    distance_from_start_hash[city]
                                  end

    current_city = unvisited_city_min_distance

    step 3 
  end

  # SUMMARY:  FIND THE SMALL DISTANCE FROM ALL THE UNVISITED CITIES AND MAKE THAT ONE AS THE CURRENT CITY THEN GO BACK TO STEP 3
              # THIS IS THE MOVE STEP



# Link: http://en.wikipedia.org/wiki/Dijkstra's_algorithm

# Notes:
# Nodes => points
# Edge => nature of relationship

# >>>>>>>>>>>>>>>>>>>>>>        Gaby's algorithm      <<<<<<<<<<<<<<<<<<<<<<<<<<<<

# Pseudocode for Gaby's algorithm:
  # Finding Shortest distance:
    # going to each road
    # find the distance of each of them
    # sort it by the shortest to longest distance
    # return the road with the shortest distance 

    # Implementation
      # Start with start_city
    # >> New w/exeption << :  if only road available, bike_on_road
    # else
      # Select the shortest distance for the next city
      # continue doing loop
      # end when hits end_city
      # >>>>>>>>>>>>EXCEPTION<<<<<<<<<<<<
        # dont go backwards:
        # bike on road to shortest road but dont bike to roads left 


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

