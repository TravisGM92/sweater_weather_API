# frozen_string_literal: true

class MapFacade
  def self.get_distance(start, finish)
    MapService.get_distance(start, finish)[:route][:distance]
  end
end
