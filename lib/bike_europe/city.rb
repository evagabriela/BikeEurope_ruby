
class City

  attr_reader :lat, :lng

  def initialize(name, lat, lng)
    @name, @lat, @lng = name, lat, lng
  end

  Berlin    = self.new('Berlin',    52.482668, 13.359275)
  Paris     = self.new('Paris',     48.980405, 2.2851849)
  Milan     = self.new('Milan',     45.520543, 9.1419459)
  Frankfurt = self.new('Frankfurt', 50.078848, 8.6349115)
  Munich    = self.new('Munich',    48.166229, 11.558089)
  Zurich    = self.new('Zurich',    47.383444, 8.5254142)
  Tours     = self.new('Tours',     47.413572, 0.6810506)
  Lyon      = self.new('Lyon',      45.767122, 4.8339568)
  Vienna    = self.new('Vienna',    48.224431, 16.389240)
  Prague    = self.new('Prague',    50.092396, 14.436144)
  Krakow    = self.new('Krakow',    50.050363, 19.928578)
  Warsaw    = self.new('Warsaw',    52.254756, 21.005968)
  Hamburg   = self.new('Hamburg',   53.539699, 9.9977143)
  Antwerp   = self.new('Antwerp',   51.220613, 4.3954882)
  Torino    = self.new('Torino',    45.105321, 7.6451957)
  Rome      = self.new('Rome',      42.032845, 12.390408)

  def kilometers_to(other)
    Util.kilometers_between(lat, lng, other.lat, other.lng)
  end

  def roads
    @roads ||= Road::ALL.select {|road| road.a == self || road.b == self }
   
  end

  def adjacent_cities
    roads.map {|road| road.the_city_opposite(self) }
  end

  def to_s
    @name
  end

  def ==(other)
    self.lat == other.lat && self.lng == other.lng
  end
end