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
    require "pry"; binding.pry
  end

  it '.get_hourly(data, eta)' do


  end


  it '.format_data(origin, finish, eta, weather)' do


  end

  it '.get_trip(origin, finish)' do


  end
end
