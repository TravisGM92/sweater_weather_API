# frozen_string_literal: true

class ForecastService
  def self.conn
    Faraday.new('https://api.openweathermap.org')
  end

  def self.get_weather(coords)
    lat = coords.split(', ')[0].to_f
    lon = coords.split(', ')[1].to_f
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
