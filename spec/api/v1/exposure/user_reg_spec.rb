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

    json = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(json.keys).to eq(['data'])
    expect(json['data'].keys).to eq(%w[id type attributes])
    expect(json['data']['attributes'].keys).to eq(%w[email api_key])
    json['data']['attributes'].each_value do |attr|
      expect(attr).to be_a(String)
    end
  end

  it 'unsuccesful API call returns some kind of 400 code and description for error' do

    body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end

    expect(response.status).to eq(403)
    expect(response.body).to eq("\"Credentials are bad\"")
  end
end
