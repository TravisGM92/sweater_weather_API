require 'rails_helper'

RSpec.describe 'Weather API call' do
  def conn(uri)
  url = 'https://api.openweathermap.org' + uri
  Faraday.new(url)
end
  it 'gets weather of specific location, according to lat and long coordinates' do
    lat = '40.7128'
    long = '74.0060'

    response = conn('/api/v1/items/179').get

    response = conn("/data/2.5/onecall?units=imperial&lat=#{lat}&lon=#{long}&exclude=minutely&appid=#{ENV['WEATHER_KEY']}").get

    expect(response).to be_successful
    json = JSON.parse(response.body)
    require "pry"; binding.pry
  end
end
