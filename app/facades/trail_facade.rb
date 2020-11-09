# frozen_string_literal: true

class TrailFacade
  def self.get_trail_info(info)
    coords = Forecast.convert_coordinates(GeoCodeService.get_coordinates(info))
    weather = ForecastService.get_weather(coords)
    current_weather = CurrentWeather.new(weather[:current])
    trails = TrailService.get_trails(coords)
    format_info(current_weather, trails, info)
  end

  def self.format_info(weather, trails, start)
    array = []
    if trails[:trails] == []
      'location not found'
    else
      trails[:trails].each do |info|
        array << CreateTrail.new(info, start)
      end
      {
        'weather': weather,
        'trails': array
      }
    end
  end
end
