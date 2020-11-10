# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoadTrip API' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'successful API call returns JSON object with specific attributes' do
    # body1 = {
    #   "email": 'whatever@example.com',
    #   "password": 'password',
    #   "password_confirmation": 'password'
    # }
    #
    # response = conn('/api/v1/users').post do |request|
    #   request.body = body1
    # end

    # if database is reset, have to create a new user by uncommenting above lines

    body = {
      "origin": 'Denver, CO',
      "destination": 'Estes Park, CO',
      "api_key": 'EFi8FSk6Efm2azGclIHrLAtt'
    }

    response = conn('/api/v1/road_trip').post do |request|
      request.body = body
    end

    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.keys).to eq(['data'])
    expect(json['data']['id']).to be_nil
    expect(json['data']['type']).to eq('roadtrip')
    expect(json['data'].keys).to eq(%w[id type attributes])
    expect(json['data']['attributes'].keys).to eq(%w[start_city end_city travel_time weather_at_eta])
    expect(json['data']['attributes']['start_city']).to be_a(String)
    expect(json['data']['attributes']['end_city']).to be_a(String)
    expect(json['data']['attributes']['travel_time']).to be_a(String)
    expect(json['data']['attributes']['weather_at_eta']).to be_a(Hash)

    expect(json['data']['attributes']['weather_at_eta'].keys).to eq(%w[temperature conditions])
    expect(json['data']['attributes']['weather_at_eta']['temperature']).to be_a(Float)
    expect(json['data']['attributes']['weather_at_eta']['conditions']).to be_a(String)
  end

  it 'lack of API key returns 401 code' do
    # body = {
    #   "password": 'password',
    #   "password_confirmation": 'password'
    # }
    #
    # response = conn('/api/v1/users').post do |request|
    #   request.body = body
    # end
    #
    # expect(response.status).to eq(400)
    # expect(response.body).to eq('"Required information missing or incorrect"')
    #
    # body2 = {
    #   "email": 'whatever@example.com',
    #   "password_confirmation": 'password'
    # }
    #
    # response2 = conn('/api/v1/users').post do |request|
    #   request.body = body2
    # end
    #
    # expect(response2.status).to eq(400)
  end
end
