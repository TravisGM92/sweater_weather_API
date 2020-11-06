require 'rails_helper'

RSpec.describe 'Forecast API has multiple attributes' do
  before(:each) do
    get "/api/v1/forecast?location=denver,co"

    expect(response).to be_successful
    @forecast = JSON.parse(response.body)
  end
  
  it "gets specific info" do
    strings = %w(date conditions icon sunrise sunset datetime time wind_speed wind_direction)
    integers = %w(max_temp min_temp feels_like temperature humidity uvi visibility)

    expected_weather_values = %w(current_weather daily_weather hourly_weather)

    expected_current_weather_keys = %w(datetime sunrise sunset temperature feels_like humidity visibility uvi conditions icon)
    expected_daily_weather_keys = %w(date sunrise sunset max_temp min_temp conditions icon)
    expected_hourly_weather_keys = %w(time wind_speed wind_direction conditions icon)

    expected_current_weather_keys.each do |attr|
      expect(@forecast['data']['attributes']['current_weather']).to include(attr)
    end

    array1 = []
    array2 = []
    array3 = []
    array4 = []

    @forecast['data'].each do |key, value|
      if key == 'id'
        expect(value).to eq(nil)
      elsif key == 'type'
        expect(value).to eq('forecast')
      elsif key == 'attributes'
        value.keys.each do |name|
          if !expected_weather_values.include?(name)
            array1 << name
          end
        end
        value.each do |key, value|
          if key == 'current_weather'
            value.keys.each do |name1|
              if !expected_current_weather_keys.include?(name1)
                array2 << name1
              end
            end
            value.each do |key1, value1|
              if strings.include?(key1)
                expect(value1).to be_a(String)
              else
                expect(value1).to_not be_a(String)
              end
            end
          elsif key == 'daily_weather'
            value.each do |day|
              day.each do |key2, value2|
                if !expected_daily_weather_keys.include?(key2)
                  array3 << key2
                end
                if strings.include?(key2)
                  expect(value2).to be_a(String)
                else
                  expect(value2).to_not be_a(String)
                end
              end
            end
          elsif key == 'hourly_weather'
            value.each do |time|
              time.each do |key3, value3|
                if !expected_hourly_weather_keys.include?(key3)
                  array4 << key3
                end
                if strings.include?(key3)
                  expect(value3).to be_a(String)
                else
                  expect(value3).to_not be_a(String)
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
