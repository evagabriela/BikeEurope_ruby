module Util
  RADIANS = 180/3.14169
  def self.kilometers_between(lat1, lng1, lat2, lng2)
    a1 = lat1 / RADIANS
    a2 = lng1 / RADIANS
    b1 = lat2 / RADIANS
    b2 = lng2 / RADIANS

    t1 = Math.cos(a1) * Math.cos(a2) * Math.cos(b1) * Math.cos(b2)
    t2 = Math.cos(a1) * Math.sin(a2) * Math.cos(b1) * Math.sin(b2)
    t3 = Math.sin(a1) * Math.sin(b1)

    6366 * Math.acos(t1 + t2 + t3)
  end
end