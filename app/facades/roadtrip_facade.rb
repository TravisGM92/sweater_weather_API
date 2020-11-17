# frozen_string_literal: true

class RoadtripFacade
  def self.get_trip(origin, finish)
    result = MapService.get_distance(origin, finish)
    if (result[:info][:statuscode]).zero?
      arrival_coords = format_coords(finish)
      eta = result[:route][:realTime]
      weather = format_weather(ForecastService.get_weather(arrival_coords), eta)
      RoadTrip.new(format_data(origin, finish, eta, weather))
    else
      { 'error': result[:info], 'origin': origin, 'finish': finish }
    end
  end

  def self.format_coords(location)
    result = GeoCodeService.get_coordinates(location)
    if result.first.class != Coordinates
      lat = result[:results][0][:locations][0][:latLng][:lat]
      lon = result[:results][0][:locations][0][:latLng][:lng]
      "#{lat}, #{lon}"
    else
      result
    end
  end

  def self.format_weather(data, eta)
    if eta < 86_400
      get_hourly(data, eta)
    else
      get_daily(data, eta)
    end
  end

  def self.get_hourly(data, eta)
    time = (eta / 3600).floor
    time -= 1 if time.positive?
    data[:hourly][time]
  end

  def self.get_daily(data, eta)
    days = ((eta.to_f / 86_400).round(0) - 1)
    data[:daily][days]
  end

  def self.format_data(origin, finish, eta, weather)
    {
      'start': origin,
      'finish': finish,
      'eta': eta,
      'weather': weather
    }
  end
end
