# frozen_string_literal: true

require 'rails_helper'

describe CurrentWeather, type: :model do
  it 'Creates a current_weather object with specific attributes' do
    data = {
      dt: 1_595_242_800,
      sunrise: 1_595_242_800,
      sunset: 1_595_242_800,
      temp: 23.4,
      feels_like: 23,
      humidity: 110,
      uvi: 20,
      visibility: 20,
      weather: [description: 'Good stuff', icon: 'Here it is']
    }
    weather = CurrentWeather.new(data)

    expect(weather).to be_a(CurrentWeather)
    expect(weather.datetime).to be_a(Time)
    expect(weather.sunrise).to be_a(Time)
    expect(weather.sunset).to be_a(Time)
    expect(weather.temperature).to be_a(Float)
    expect(weather.feels_like).to be_an(Integer)
    expect(weather.humidity).to be_an(Integer)
    expect(weather.uvi).to be_an(Integer)
    expect(weather.visibility).to be_an(Integer)
    expect(weather.conditions).to be_a(String)
    expect(weather.icon).to be_a(String)
  end
end
