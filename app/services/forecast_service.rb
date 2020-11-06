# frozen_string_literal: true

class ForecastService
  def self.get_weather(coords)
    conn = Faraday.new(url: 'https://api.openweathermap.org')
    response = conn.get("/data/2.5/onecall?units=imperial&lat=#{coords.split(', ')[0].to_f}&lon=#{coords.split(', ')[1].to_f}&exclude=minutely&appid=#{ENV['WEATHER_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
