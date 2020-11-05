class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :current_weather do |data|
    today = Time.at(data[:current][:dt])
    sun = Time.at(data[:current][:sunrise])
    set = Time.at(data[:current][:sunset])
      {
        'datetime': "#{today.year}-#{today.month}-#{today.day} #{today.hour}:#{today.min}:#{today.sec}",
        'sunrise': "#{sun.year}-#{sun.month}-#{sun.day} #{sun.hour}:#{sun.min}:#{sun.sec}",
        'sunset': "#{set.year}-#{set.month}-#{set.day} #{set.hour}:#{set.min}:#{set.sec}",
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
  end

    def self.hash_it(data)
      data.map do |info|
        today = Time.at(info[:dt])
        sun = Time.at(info[:sunrise])
        set = Time.at(info[:sunset])
          {
            'date': "#{today.year}-#{today.month}-#{today.day} #{today.hour}:#{today.min}:#{today.sec}",
            'sunrise': "#{sun.year}-#{sun.month}-#{sun.day} #{sun.hour}:#{sun.min}:#{sun.sec}",
            'sunset': "#{set.year}-#{set.month}-#{set.day} #{set.hour}:#{set.min}:#{set.sec}",
            'max_temp': info[:temp][:max],
            'min_temp': info[:temp][:min],
            'conditions': info[:weather][0][:description],
            'icon': info[:weather][0][:icon]
          }
    end
  end
end
