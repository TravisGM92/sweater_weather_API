require 'rails_helper'

describe 'Forecast API' do
  it 'can send back a json forecast object by consuming a weather API' do

    get "/api/v1/forecast?location=denver,co"

    expect(response).to be_successful

    forecast = JSON.parse(response.body)
    require "pry"; binding.pry

    expect(forecast['data']['id']).to be_nil
    expect(forecast['type']).to eq('forecast')

    expect(forecast['data']['attributes']).to have_key('current_weather')
    #current_weather
    exepect(forecast['data']['attributes']['current_weather']).to have_key('datetime')
    exepect(forecast['data']['attributes']['current_weather']['date_time']).to be_a(String)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('temperature')
    exepect(forecast['data']['attributes']['current_weather']['temperature']).to be_a(Float)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('feels_like')
    exepect(forecast['data']['attributes']['current_weather']['feels_like']).to be_a(Float)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('humidity')
    exepect(forecast['data']['attributes']['current_weather']['humidity']).to be_a(Float)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('uvi')
    exepect(forecast['data']['attributes']['current_weather']['uvi']).to be_a(Float)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('visibility')
    exepect(forecast['data']['attributes']['current_weather']['visibility']).to be_a(Float)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('conditions')
    exepect(forecast['data']['attributes']['current_weather']['conditions']).to be_a(String)

    exepect(forecast['data']['attributes']['current_weather']).to have_key('icon')
    exepect(forecast['data']['attributes']['current_weather']['icon']).to be_a(String)

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
