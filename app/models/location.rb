class Location < ActiveRecord::Base
  attr_accessible :lat, :lon, :msl, :name

  #relations
  has_many :instruments

end
