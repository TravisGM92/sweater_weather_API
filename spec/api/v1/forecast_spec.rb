require 'rails_helper'

describe 'Forecast API' do
  it 'can send back a json forecast object by consuming a weather API' do

    get "/api/v1/forecast?location=denver,co"

    expect(response).to be_successful

    forecast = JSON.parse(response.body)
    # require "pry"; binding.pry

    expect(forecast['data']['id']).to be_nil
    expect(forecast['data']['type']).to eq('forecast')

    #current_weather
    expect(forecast['data']['attributes']).to have_key('current_weather')
    expect(forecast['data']['attributes']['current_weather']).to have_key('datetime')
    expect(forecast['data']['attributes']['current_weather']['datetime']).to be_a(String)

    expect(forecast['data']['attributes']['current_weather']).to have_key('temperature')
    expect(forecast['data']['attributes']['current_weather']['temperature']).to be_a(Float)

    expect(forecast['data']['attributes']['current_weather']).to have_key('feels_like')
    expect(forecast['data']['attributes']['current_weather']['feels_like']).to be_a(Float)

    expect(forecast['data']['attributes']['current_weather']).to have_key('humidity')
    expect(forecast['data']['attributes']['current_weather']['humidity']).to_not be_a(String)

    expect(forecast['data']['attributes']['current_weather']).to have_key('uvi')
    expect(forecast['data']['attributes']['current_weather']['uvi']).to be_a(Float)

    expect(forecast['data']['attributes']['current_weather']).to have_key('visibility')
    expect(forecast['data']['attributes']['current_weather']['visibility']).to_not be_a(String)

    expect(forecast['data']['attributes']['current_weather']).to have_key('conditions')
    expect(forecast['data']['attributes']['current_weather']['conditions']).to be_a(String)

    expect(forecast['data']['attributes']['current_weather']).to have_key('icon')
    expect(forecast['data']['attributes']['current_weather']['icon']).to be_a(String)

    # expect(data['attributes']).to have_key('merchant_id')
    # expect(data['attributes']['merchant_id']).to be_an(Integer)
    #
    # expect(data['attributes']).to have_key('created_at')
    # expect(data['attributes']['created_at']).to be_a(String)
    #
    # expect(data['attributes']).to have_key('updated_at')
    # expect(data['attributes']['updated_at']).to be_a(String)

  end
end
