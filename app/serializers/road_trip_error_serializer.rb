# frozen_string_literal: true

class RoadTripErrorSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }

  attribute :start_city do |data|
    data[:origin]
  end

  attribute :end_city do |data|
    data[:finish]
  end

  attribute :travel_time do |_data|
    'impossible'
  end

  attribute :weather_at_eta do |_data|
    []
  end
end
