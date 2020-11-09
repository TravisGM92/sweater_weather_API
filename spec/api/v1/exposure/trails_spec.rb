require 'rails_helper'

RSpec.describe 'Forecast API has multiple attributes' do
  it 'gets specific info, in specific format' do

    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful
    trails = JSON.parse(response.body)


    expect(trails['data'].keys).to eq(%w[id type attributes])
    expect(trails['data']['id']).to be_nil
    expect(trails['data']['type']).to eq('trail')
    expect(trails['data']['attributes']).to be_a(Hash)

    expect(trails['data']['attributes'].keys).to eq(%w[location forecast trails])
    expect(trails['data']['attributes']['location']).to be_a(String)
    expect(trails['data']['attributes']['forecast']).to be_a(Hash)

    expect(trails['data']['attributes']['forecast'].keys).to eq(%w[summary temperature])
    trails['data']['attributes']['forecast'].values.each do |name|
      expect(name).to be_a(String)
    end

    expect(trails['data']['attributes']['trails']).to be_an(Array)
    expect(trails['data']['attributes']['trails'].length).to eq(10)

    trails['data']['attributes']['trails'].each do |trail|
      expect(trail.keys).to eq(%w[name summary difficulty location distance_to_trail])
      trail.values.each do |name|
        expect(name).to be_a(String)
      end
    end
  end
end
