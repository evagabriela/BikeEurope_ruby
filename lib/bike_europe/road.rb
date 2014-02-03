
class Road
  require 'set'
  ALL = Set.new

  attr_reader :a, :b, :distance

  def initialize(a, b)
    raise "Roads must have two cities" if a == b
    @a = a
    @b = b
    @distance = a.kilometers_to(b)
  end

  def the_city_opposite(city)
    raise "#{city} isn't connected to #{self}" unless a == city || b == city
    city == a ? b : a
  end

  def to_s
    "#{a} | #{b} (#{"%.0f" % distance} km)"
  end

  def self.between(a, b)
    ALL.detect do |road|
      return road if (road.a == a && road.b == b) || (road.a == b && road.b == a)
    end
    raise "There is no road between " + a.to_s + " and " + b.to_s
  end

  ALL.add self.new(City::Hamburg,   City::Berlin)
  ALL.add self.new(City::Hamburg,   City::Antwerp)
  ALL.add self.new(City::Hamburg,   City::Frankfurt)
  ALL.add self.new(City::Berlin,    City::Warsaw)
  ALL.add self.new(City::Berlin,    City::Prague)
  ALL.add self.new(City::Antwerp,   City::Paris)
  ALL.add self.new(City::Paris,     City::Tours)
  ALL.add self.new(City::Paris,     City::Lyon)
  ALL.add self.new(City::Paris,     City::Zurich)
  ALL.add self.new(City::Paris,     City::Frankfurt)
  ALL.add self.new(City::Frankfurt, City::Prague)
  ALL.add self.new(City::Krakow,    City::Warsaw)
  ALL.add self.new(City::Krakow,    City::Prague)
  ALL.add self.new(City::Krakow,    City::Vienna)
  ALL.add self.new(City::Vienna,    City::Munich)
  ALL.add self.new(City::Vienna,    City::Prague)
  ALL.add self.new(City::Zurich,    City::Milan)
  ALL.add self.new(City::Lyon,      City::Torino)
  ALL.add self.new(City::Torino,    City::Milan)
  ALL.add self.new(City::Torino,    City::Rome)
  ALL.add self.new(City::Milan,     City::Rome)
  

end

