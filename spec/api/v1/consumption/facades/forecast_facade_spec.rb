# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forecast Facade' do

  it '.get_weather_by_coordinates(info)' do
    info = 'denver,co'
    result = ForecastFacade.get_weather_by_coordinates(info)
    expect(result).to be_a(Hash)
    expect(result.keys).to eq(%i[lat lon timezone timezone_offset current hourly daily])
    expect(result[:timezone]).to eq('America/Denver')

    result[:current].each do |key, value|
      if key != :weather
        expect(value).to_not be_a(String)
        expect(value).to_not be_nil
      else
        expect(value).to be_an(Array)
      end
    end

    expected = %i[dt temp feels_like pressure humidity dew_point wind_speed wind_deg weather clouds pop]
    expected.each do |name|
      result[:daily].each do |day|
        expect(day.keys.include?(name)).to eq(true)
        expect(day.keys.include?(:sunrise)).to eq(true)
        expect(day.keys.include?(:sunset)).to eq(true)
        expect(day.keys.include?(:uvi)).to eq(true)
      end
      result[:hourly].each do |hour|
        expect(hour.keys.include?(name)).to eq(true)
      end
    end
    expect(result[:hourly].length).to eq(48)
  end
end
