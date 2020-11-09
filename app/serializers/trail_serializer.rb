# frozen_string_literal: true

class TrailSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :location do |data|
    data[:trails][0].start
  end

  attribute :forecast do |data|
    {
      'summary': data[:weather].conditions,
      'temperature': data[:weather].temperature.to_s
    }
  end

  attribute :trails do |data|
    format_trails(data[:trails])
  end

  def self.format_trails(data)
    result = data.map do |trail|
      {
        'name': trail.name,
        'summary': trail.summary,
        'difficulty': trail.difficulty,
        'location': trail.location,
        'distance_to_trail': trail.distance_to_trail.to_s
      }
    end
  end
end
