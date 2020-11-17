class Coordinates < ApplicationRecord
  validates_presence_of :city
  validates_presence_of :area
  validates_presence_of :lat
  validates_presence_of :lng

  def self.find_coords(info)
    city = info.split(',')[0]
    Coordinates.where(city: city)
  end
end
