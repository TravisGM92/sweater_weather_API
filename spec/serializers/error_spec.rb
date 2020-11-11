require 'rails_helper'

RSpec.describe 'Error Serializer' do
  it 'has specific attributes' do
    data = {
      start: 'start',
      finish: 'end'
    }

    result = ErrorSerializer.new(data)
    expect(result).to be_a(ErrorSerializer)

    response = JSON.parse(result.to_json, symbolize_names: true)

    expect(response.keys).to eq([:data])
    expect(response[:data].keys).to eq(%i[id type])
    expect(response[:data][:id]).to be_nil
    expect(response[:data][:type]).to eq('error')
  end
end
