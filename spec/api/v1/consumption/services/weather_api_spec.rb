# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Weather API call' do
  def conn(uri)
    url = "https://api.openweathermap.org#{uri}"
    Faraday.new(url)
  end
  it 'gets weather of specific location, according to lat and long coordinates' do
    lat = '40.7128'
    long = '-74.0060'

    response = conn("/data/2.5/onecall?units=imperial&lat=#{lat}&lon=#{long}&exclude=minutely&appid=#{ENV['WEATHER_KEY']}").get

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json.keys).to eq(%w[lat lon timezone timezone_offset current hourly daily])
    expect(json['lat']).to_not be_a(String)
    expect(json['lon']).to_not be_a(String)
    expect(json['timezone']).to be_a(String)
    expect(json['timezone_offset']).to_not be_a(String)


    json['current'].each do |key, value|
      if key != 'weather'
        expect(value).to_not be_a(String)
        expect(value).to_not be_nil
      else
        expect(value).to be_an(Array)
      end
    end

    expected = %w[dt temp feels_like pressure humidity dew_point clouds wind_speed wind_deg weather]

    expect(json['hourly'].length).to eq(48)
    json['hourly'].each do |hour|
      expected.each do |name|
        expect(hour.keys.include?(name)).to eq(true)
      end
      hour.each do |key, value|
        if key != 'weather'
          expect(value).to_not be_a(String)
          expect(value).to_not be_nil
        else
          expect(value).to be_an(Array)
        end
      end
    end

    expected.each do |name|
      json['daily'].each do |day|
        expect(day.keys.include?(name)).to eq(true)
        expect(day.keys.include?('sunrise')).to eq(true)
        expect(day.keys.include?('sunset')).to eq(true)
        expect(day.keys.include?('uvi')).to eq(true)
        expect(day.keys.include?('clouds')).to eq(true)
        expect(day.keys.include?('pop')).to eq(true)
      end
    end
  end
end
