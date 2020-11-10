# frozen_string_literal: true

class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :start_city do |data|
    data.start_city.to_s
  end

  attribute :end_city do |data|
    data.end_city.to_s
  end

  attribute :travel_time, &:travel_time

  attribute :weather_at_eta do |data|
    if data.weather_at_eta[:temperature].class != Hash
      {
        'temperature': data.weather_at_eta[:temperature],
        'conditions': data.weather_at_eta[:conditions]
      }
    else
      {
        'temperature': data.weather_at_eta[:temperature][:day],
        'conditions': data.weather_at_eta[:conditions]
      }
    end
  end
end
