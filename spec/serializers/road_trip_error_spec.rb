# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoadTripError Serializer' do
  it 'has specific attributes' do
    data = {
      origin: 'start',
      finish: 'end'
    }

    result = RoadTripErrorSerializer.new(data)
    response = JSON.parse(result.to_json, symbolize_names: true)

    expect(response.keys).to eq([:data])
    expect(response[:data].keys).to eq(%i[id type attributes])
    expect(response[:data][:id]).to be_nil
    expect(response[:data][:type]).to eq('road_trip_error')
    expect(response[:data][:attributes]).to be_a(Hash)

    expect(response[:data][:attributes].keys).to eq(%i[start_city end_city travel_time weather_at_eta])
    expect(response[:data][:attributes][:start_city]).to eq((data[:origin]).to_s)
    expect(response[:data][:attributes][:end_city]).to eq((data[:finish]).to_s)
    expect(response[:data][:attributes][:travel_time]).to eq('impossible')
    expect(response[:data][:attributes][:weather_at_eta]).to eq([])
  end
end
