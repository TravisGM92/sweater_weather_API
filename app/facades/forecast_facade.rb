# frozen_string_literal: true

class ForecastFacade
  def self.get_weather(info)
    coords = GeoCodeService.get_coords(info)
    ForecastService.get_weather(coords)
  end
end
