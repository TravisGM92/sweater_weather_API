# frozen_string_literal: true

class HourlyWeather
  attr_reader :time,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.at(data[:dt])
    @wind_speed = data[:wind_speed].to_s
    @wind_direction = Forecast.get_direction(data[:wind_deg])
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
