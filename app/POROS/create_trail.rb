class CreateTrail
  attr_reader :name,
              :summary,
              :difficulty,
              :location,
              :distance_to_trail,
              :start

  def initialize(data, start)
    @start = start
    @name = data[:name]
    @summary = data[:summary]
    @difficulty = data[:difficulty]
    @location = data[:location]
    @distance_to_trail = MapFacade.get_distance(start, data[:location])
  end
end
