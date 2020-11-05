class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :current_weather do |data|
    # require "pry"; binding.pry
      {
        'datetime': Time.at(data[:current][:dt]),
        'sunrise': Time.at(data[:current][:sunrise]),
        'sunset': Time.at(data[:current][:sunset]),
        'temperature': data[:current][:temp],
        'feels_like': data[:current][:feels_like],
        'humidity': data[:current][:humidity],
        'uvi': data[:current][:uvi],
        'visibility': data[:current][:visibility],
        'conditions': data[:current][:weather][0][:description],
        'icon': data[:current][:weather][0][:icon]
      }
  end

  attribute :daily_weather do |data|
    self.hash_it(data[:daily])
    require "pry"; binding.pry
  end

    def self.hash_it(data)
      data.map do |info|
          {
            'date': Time.at(info[:dt]),
            'sunrise': Time.at(info[:sunrise]),
            'sunset': Time.at(info[:sunset]),
            'max_temp': info[:temp][:max],
            'min_temp': info[:temp][:min],
            'conditions': info[:weather][0][:description],
            'icon': info[:weather][0][:icon]
          }
    end
  end
end
