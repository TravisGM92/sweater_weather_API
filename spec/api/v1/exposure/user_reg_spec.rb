# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User registration API' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end

  it 'successful API call registers a new user' do
    body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(json.keys).to eq([:data])
    expect(json[:data].keys).to eq(%i[id type attributes])
    expect(json[:data][:attributes].keys).to eq(%i[email api_key])
    json[:data][:attributes].each_value do |attr|
      expect(attr).to be_a(String)
    end
  end

  xit 'unsuccesful API call returns some kind of 400 code and description for error' do
    user1 = create(:user)
    require 'pry'; binding.pry
    body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end
    require 'pry'; binding.pry
  end
end
