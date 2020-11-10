# frozen_string_literal: true

class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :start_city do |data|
    "#{data.start_city}"
  end

  attribute :end_city do |data|
    "#{data.end_city}"
  end

  attribute :travel_time do |data|
    data.travel_time
  end

  attribute :weather_at_eta do |data|
    {
      'temperature': data.weather_at_eta[:temperature],
      'conditions': data.weather_at_eta[:conditions]
    }
  end
end
