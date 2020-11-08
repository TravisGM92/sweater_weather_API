# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forecast API has multiple attributes' do
  it 'gets specific info, in specific format' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    forecast = JSON.parse(response.body)

    strings = %w[date conditions icon sunrise sunset datetime time wind_speed wind_direction]
    expected_weather_values = %w[current_weather daily_weather hourly_weather]

    expected_current_weather_keys = %w[datetime sunrise sunset temperature feels_like humidity visibility uvi conditions icon]
    expected_daily_weather_keys = %w[date sunrise sunset max_temp min_temp conditions icon]
    expected_hourly_weather_keys = %w[time wind_speed wind_direction conditions icon]

    # expect forecast['data']['attributes']['current_weather'] to have specific keys
    expected_current_weather_keys.each do |attr|
      expect(forecast['data']['attributes']['current_weather']).to include(attr)
    end

    extra_attributes_in_attributes = []
    extra_attributes_in_current_weather = []
    extra_attributes_in_daily_weather = []
    extra_attributes_in_hourly_weather = []
    extra_attributes_in_data = []
    forecast['data'].each do |key, value|
      case key
        # expect forecast['data'] to have 'id' as key, expect it to be nil
      when 'id'
        expect(value).to eq(nil)
      when 'type'
        # expect forecast['data']['type'] to be 'forecast'
        expect(value).to eq('forecast')
      when 'attributes'
        value.each_key do |name|
          # expect forecast['data']['attributes'] to have specific keys
          extra_attributes_in_attributes << name unless expected_weather_values.include?(name)
        end
        value.each do |key1, value1|
          case key1
          when 'current_weather'
            # expect forecast['data']['attributes']['current_weather'] to have specific keys
            value1.each_key do |name1|
              extra_attributes_in_current_weather << name1 unless expected_current_weather_keys.include?(name1)
            end
            value1.each do |key2, value2|
              # expect forecast['data']['attributes']['current_weather'] keys to be specific class
              if strings.include?(key2)
                expect(value2).to be_a(String)
              else
                expect(value2).to_not be_a(String)
              end
            end
          when 'daily_weather'
            value1.each do |day|
              day.each do |key3, value3|
                extra_attributes_in_daily_weather << key3 unless expected_daily_weather_keys.include?(key3)
                if strings.include?(key3)
                  # expect forecast['data']['attributes']['daily_weather'] keys to be specific class
                  expect(value3).to be_a(String)
                else
                  expect(value3).to_not be_a(String)
                end
              end
            end
          when 'hourly_weather'
            value1.each do |time|
              time.each do |key4, value4|
                extra_attributes_in_hourly_weather << key4 unless expected_hourly_weather_keys.include?(key4)
                if strings.include?(key4)
                  # expect forecast['data']['attributes']['hourly_weather'] keys to be specific class
                  expect(value4).to be_a(String)
                else
                  expect(value4).to_not be_a(String)
                end
              end
            end
          end
        end
      else
        # checks if there are any other keys within 'data' besides 'id', 'type' and 'attributes'
        extra_attributes_in_data << key
      end
    end
    expect(extra_attributes_in_attributes).to be_empty
    expect(extra_attributes_in_current_weather).to be_empty
    expect(extra_attributes_in_daily_weather).to be_empty
    expect(extra_attributes_in_hourly_weather).to be_empty
    expect(extra_attributes_in_data).to be_empty
  end
end
