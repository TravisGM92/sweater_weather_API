# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forecast API has multiple attributes' do
  before(:each) do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    @forecast = JSON.parse(response.body)
  end

  it 'gets specific info' do
    strings = %w[date conditions icon sunrise sunset datetime time wind_speed wind_direction]
    # integers = %w[max_temp min_temp feels_like temperature humidity uvi visibility]

    expected_weather_values = %w[current_weather daily_weather hourly_weather]

    expected_current_weather_keys = %w[datetime sunrise sunset temperature feels_like humidity visibility uvi conditions icon]
    expected_daily_weather_keys = %w[date sunrise sunset max_temp min_temp conditions icon]
    expected_hourly_weather_keys = %w[time wind_speed wind_direction conditions icon]

    expected_current_weather_keys.each do |attr|
      expect(@forecast['data']['attributes']['current_weather']).to include(attr)
    end

    array1 = []
    array2 = []
    array3 = []
    array4 = []

    @forecast['data'].each do |key, value|
      case key
      when 'id'
        expect(value).to eq(nil)
      when 'type'
        expect(value).to eq('forecast')
      when 'attributes'
        value.each_key do |name|
          array1 << name unless expected_weather_values.include?(name)
        end
        value.each do |key1, value1|
          case key1
          when 'current_weather'
            value1.each_key do |name1|
              array2 << name1 unless expected_current_weather_keys.include?(name1)
            end
            value1.each do |key2, value2|
              if strings.include?(key2)
                expect(value2).to be_a(String)
              else
                expect(value2).to_not be_a(String)
              end
            end
          when 'daily_weather'
            value1.each do |day|
              day.each do |key3, value3|
                array3 << key3 unless expected_daily_weather_keys.include?(key3)
                if strings.include?(key3)
                  expect(value3).to be_a(String)
                else
                  expect(value3).to_not be_a(String)
                end
              end
            end
          when 'hourly_weather'
            value1.each do |time|
              time.each do |key4, value4|
                array4 << key4 unless expected_hourly_weather_keys.include?(key4)
                if strings.include?(key4)
                  expect(value4).to be_a(String)
                else
                  expect(value4).to_not be_a(String)
                end
              end
            end
          end
        end
      end
    end
    expect(array1).to eq([])
    expect(array2).to eq([])
    expect(array3).to eq([])
    expect(array4).to eq([])
  end
end
