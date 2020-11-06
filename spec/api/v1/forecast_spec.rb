require 'rails_helper'

RSpec.describe 'Forecast API has multiple attributes' do
  before(:each) do
    get "/api/v1/forecast?location=denver,co"

    expect(response).to be_successful
    @forecast = JSON.parse(response.body)
  end
  it "gets only specific keys back within the json['data']['attributes'] hash" do
    expected = %w(current_weather daily_weather hourly_weather)
    array = []
    @forecast['data']['attributes'].keys.each do |attr|
      if !expected.include?(attr)
        array << attr
      end
    end
    expect(array).to eq([])
  end

  it 'can send back a json forecast, current weather, object by consuming a weather API' do
    expected = %w(datetime sunrise sunset temperature feels_like humidity visibility uvi conditions icon)
    strings = %w(datetime conditions icon sunrise sunset)
    integers = %w(temperature feels_like humidity uvi visibility)
    # expect json attributes[:current_weather] to have these and only these...
    array = []
    expected.each do |attr|
      expect(@forecast['data']['attributes']['current_weather']).to include(attr)
    end
    @forecast['data']['attributes']['current_weather'].keys.each do |attr|
      if !expected.include?(attr)
        array << attr
      end
    end
    expect(array).to eq([])

    # expect json keys to only be data
    expect(@forecast.keys).to eq(['data'])

    # expect json['data'] keys to have only 3
    expect(@forecast['data'].keys).to eq(["id", "type", "attributes"])
    @forecast['data']['attributes']['current_weather'].each do |key, value|
      if strings.include?(key)
        expect(value).to be_a(String)
      else
        if value.class == Integer
          expect(value).to be_an(Integer)
        else
          expect(value).to be_a(Float)
        end
      end
    end
  end

  it 'can send back a json forecast, daily weather, object by consuming a weather API' do
    expected = %w(date sunrise sunset max_temp min_temp conditions icon)

    array = []

    # has expected keys
    expected.each do |attr|
      @forecast['data']['attributes']['daily_weather'].each do |info|
        expect(info.keys).to include(attr)
        expect(info['date']).to be_a(String)
        expect(info['sunrise']).to be_a(String)
        expect(info['sunset']).to be_a(String)
        expect(info['max_temp']).to_not be_a(String)
        expect(info['min_temp']).to_not be_a(String)
        expect(info['conditions']).to be_a(String)
        expect(info['icon']).to be_a(String)
        info.keys.each do |attr|
          if !expected.include?(attr)
            array << attr
          end
        end
      end
    end

    expect(array).to eq([])
  end

  it 'can send back a json forecast, hourly weather, object by consuming a weather API' do
    # expect forecast['data']['attributes']['hourly_weather'] to only...
    expected = %w(time wind_speed wind_direction conditions icon)
    array = []
    @forecast['data']['attributes']['hourly_weather'].each do |day|
      day.keys.each do |attr|
        if !expected.include?(attr)
          array << attr
        end
        day.values.each do |val|
          expect(val).to be_a(String)
        end
      end
    end
    expect(array).to eq([])
  end
end
