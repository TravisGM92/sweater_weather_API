# frozen_string_literal: true

class ForecastService
  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end

  def self.get_weather(coords)

    if coords.class != Array && coords.first.class != Coordinates
      lat = coords.split(', ')[0].to_f
      lon = coords.split(', ')[1].to_f
    else
      lat = coords.first.lat.to_f
      lon = coords.first.lat.to_f
    end
    response = conn.get('data/2.5/onecall') do |req|
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:exclude] = 'minutely'
      req.params[:units] = 'imperial'
      req.params[:appid] = ENV['WEATHER_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
