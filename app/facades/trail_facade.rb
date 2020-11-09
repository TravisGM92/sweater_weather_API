# frozen_string_literal: true

class TrailFacade
  def self.get_trail_info(info)
    coords = Forecast.convert_coordinates(GeoCodeService.get_coordinates(info))
    weather = ForecastService.get_weather(coords)
    current_weather = CurrentWeather.new(weather[:current])
    trails = TrailService.get_trails(coords)
  end
end
