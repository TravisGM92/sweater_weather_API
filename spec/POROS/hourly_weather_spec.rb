# frozen_string_literal: true

require 'rails_helper'

describe HourlyWeather, type: :model do
  it 'Creates a hourly_weather object with specific attributes' do
    data = {
      dt: 1595242800,
      wind_speed: 22,
      wind_deg: 22,
      weather: [description: 'Good stuff', icon: 'Here it is']
    }
    weather = HourlyWeather.new(data)

    expect(weather).to be_a(HourlyWeather)
    expect(weather.time).to be_a(Time)
    expect(weather.wind_speed).to be_a(String)
    expect(weather.wind_direction).to be_a(String)
    expect(weather.conditions).to be_a(String)
    expect(weather.icon).to be_a(String)
  end
end
