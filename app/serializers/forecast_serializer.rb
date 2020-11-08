# frozen_string_literal: true

class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :current_weather do |data|
    result = CurrentWeather.new(data[:current])
    {
      'datetime': "#{result.datetime.year}-#{result.datetime.month}-#{result.datetime.day} #{result.datetime.hour}:#{result.datetime.min}:#{result.datetime.sec}",
      'sunrise': "#{result.sunrise.year}-#{result.sunrise.month}-#{result.sunrise.day} #{result.sunrise.hour}:#{result.sunrise.min}:#{result.sunrise.sec}",
      'sunset': "#{result.sunset.year}-#{result.sunset.month}-#{result.sunset.day} #{result.sunset.hour}:#{result.sunset.min}:#{result.sunset.sec}",
      'temperature': result.temperature,
      'feels_like': result.feels_like,
      'humidity': result.humidity,
      'uvi': result.uvi,
      'visibility': result.visibility,
      'conditions': result.conditions,
      'icon': result.icon
    }
  end

  attribute :daily_weather do |data|
    array = []
    data[:daily][0..4].each do |day|
      array << DailyWeather.new(day)
    end
    daily(array)
  end

  attribute :hourly_weather do |data|
    array = []
    data[:hourly].each do |hour|
      array << HourlyWeather.new(hour)
    end
    hash_hourly(array)
  end

  def self.daily(data)
    data.map do |info|
      {
        'date': "#{info.datetime.year}-#{info.datetime.month}-#{info.datetime.day}",
        'sunrise': "#{info.sunrise.year}-#{info.sunrise.month}-#{info.sunrise.day} #{info.sunrise.hour}:#{info.sunrise.min}:#{info.sunrise.sec}",
        'sunset': "#{info.sunset.year}-#{info.sunset.month}-#{info.sunset.day} #{info.sunset.hour}:#{info.sunset.min}:#{info.sunset.sec}",
        'max_temp': info.max_temp,
        'min_temp': info.min_temp,
        'conditions': info.conditions,
        'icon': info.icon
      }
    end
  end

  def self.hash_hourly(data)
    data.map do |hour|
      {
        'time': "#{hour.time.hour}:#{hour.time.min}:#{hour.time.sec}",
        'wind_speed': hour.wind_speed,
        'wind_direction': hour.wind_direction,
        'conditions': hour.conditions,
        'icon': hour.icon
      }
    end
  end
end
