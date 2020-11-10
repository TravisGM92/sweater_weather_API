# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Roadtrip Facade' do

  it '.format_coords(location)' do
    location = 'denver,co'

    result = RoadtripFacade.format_coords(location)
    expect(result).to be_a(String)
    expect(result).to eq('39.738453, -104.984853')
  end

  it '.format_weather(data, eta)' do
    #hourly
    eta = 500
    data = {
      :hourly => ['first hour', 'second hour']
    }
    result = RoadtripFacade.format_weather(data, eta)
    expect(result).to be_a(String)
    expect(result).to eq('first hour')
    #daily_and_hourly

    eta2 = 86500
    data2 = {
      :hourly => ['first hour', 'second hour'],
      :daily => ['first day', 'second day']
    }
    result2 = RoadtripFacade.format_weather(data2, eta2)
    expect(result2).to be_a(String)
    expect(result2).to eq('first day')
  end

  it '.get_hourly(data, eta)' do
    eta = 9000
    data = {
      :hourly => ['first hour', 'second hour', 'third hour']
    }
    result = RoadtripFacade.format_weather(data, eta)
    expect(result).to be_a(String)
    expect(result).to eq('second hour')

    eta2 = 13000
    result2 = RoadtripFacade.format_weather(data, eta2)
    expect(result2).to eq('third hour')
  end


  it '.format_data(origin, finish, eta, weather)' do
    origin = 'denver,co'
    finish = 'los angeles,ca'
    eta = 9000
    weather = 'vey nice weather'

    result = RoadtripFacade.format_data(origin, finish, eta, weather)

    expect(result).to be_a(Hash)
    expect(result.keys).to eq(%i[start finish eta weather])
    result.each do |key, value|
      if key != :eta
        expect(value).to be_a(String)
      else
        expect(value).to be_an(Integer)
      end
    end
  end

  it '.get_trip(origin, finish)' do
    origin = 'denver,co'
    finish = 'los angeles,ca'

    result = RoadtripFacade.get_trip(origin, finish)

    expect(result).to be_a(RoadTrip)
    expect(result.end_city).to be_a(String)
    expect(result.end_city).to eq("#{finish}")
    expect(result.start_city).to be_a(String)
    expect(result.start_city).to eq("#{origin}")
    expect(result.weather_at_eta).to be_a(Hash)
    expect(result.weather_at_eta.keys).to eq(%i[temperature conditions])
    result.weather_at_eta.each do |key, value|
      if key == :temperature
        expect(value).to be_a(Float)
      else
        expect(value).to be_a(String)
      end
    end

  end
end
