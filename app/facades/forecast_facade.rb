# frozen_string_literal: true

class ForecastFacade
  def self.get_weather_by_coordinates(info)
    coords = Forecast.convert_coordinates(GeoCodeService.get_coordinates(info))
    ForecastService.get_weather(coords)
  end
end
