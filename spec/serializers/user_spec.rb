# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Serializer' do
  it 'has specific attributes' do
    user = User.create!(email: 'new@email.com', password: 'yep')

    result = UserSerializer.new(user)

    response = JSON.parse(result.to_json, symbolize_names: true)

    expect(response.keys).to eq([:data])
    expect(response[:data].keys).to eq(%i[id type attributes])
    expect(response[:data][:id]).to eq(user.id.to_s)
    expect(response[:data][:type]).to eq('user')
    expect(response[:data][:attributes].keys).to eq(%i[email api_key])
    expect(response[:data][:attributes][:email]).to eq(user.email.to_s)
    expect(response[:data][:attributes][:api_key]).to eq(user.api_key.to_s)
  end
end
