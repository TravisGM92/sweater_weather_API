# frozen_string_literal: true

class TripFacade
  def self.get_trip(origin, finish)
    result = MapService.get_distance(origin, finish)
    arrival_coords = format_coords(finish)
    eta = result[:route][:realTime]
    weather = format_weather(ForecastService.get_weather(arrival_coords), eta)
    format_data(origin, finish, eta, weather)
  end

  def self.format_coords(location)
    result = GeoCodeService.get_coordinates(location)
    lat = result[:results][0][:locations][0][:latLng][:lat]
    lon = result[:results][0][:locations][0][:latLng][:lng]
    "#{lat}, #{lon}"
  end

  def self.format_weather(data, eta)
    if eta < 86400
      get_hourly(data, eta)
    else
      get_daily_and_hourly(data)
    end
  end

  def self.get_hourly(data, eta)
    time = (eta/3600).floor
    data[:hourly][time]
  end

  def self.format_data(origin, finish, eta, weather)
    require "pry"; binding.pry
  end
end
