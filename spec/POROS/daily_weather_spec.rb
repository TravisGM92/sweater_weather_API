# frozen_string_literal: true

require 'rails_helper'

describe DailyWeather, type: :model do
  it 'Creates a daily_weather object with specific attributes' do
    data = {
      dt: 1_595_242_800,
      sunrise: 1_595_242_800,
      sunset: 1_595_242_800,
      temp: { max: 32.4, min: 12.4 },
      weather: [description: 'Good stuff', icon: 'Here it is']
    }
    weather = DailyWeather.new(data)

    expect(weather).to be_a(DailyWeather)
    expect(weather.datetime).to be_a(Time)
    expect(weather.sunrise).to be_a(Time)
    expect(weather.sunset).to be_a(Time)
    expect(weather.max_temp).to be_a(Float)
    expect(weather.min_temp).to be_a(Float)
    expect(weather.conditions).to be_a(String)
    expect(weather.icon).to be_a(String)
  end
end
