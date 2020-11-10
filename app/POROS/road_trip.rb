# frozen_string_literal: true

class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    @start_city = data[:start]
    @end_city = data[:finish]
    @travel_time = format_time(data[:eta])
    @weather_at_eta = format_weather(data[:weather])
  end

  def format_time(data)
    result = ((data.to_f / 60) / 60)
    minute = (60 * result.modulo(1))
    if result >= 1 && result < 2
      "#{result.floor} hour and #{minute.round(0)} minutes"
    elsif result < 1
      "#{result * 60} minutes"
    else
      "#{result.floor} hours and #{minute.round(0)} minutes"
    end
  end

  def format_weather(data)
    {
      'temperature': data[:temp],
      'conditions': data[:weather][0][:description]
    }
  end
end
