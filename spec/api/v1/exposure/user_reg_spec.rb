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

  it 'duplicate email address API call returns 403 code and description for error' do
    body = {
      "email": 'whatever@example.com',
      "password": 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end

    expect(response.status).to eq(403)
    expect(response.body).to eq('"Credentials are bad"')
  end

  it 'lack of email or password returns 400 code' do
    body = {
      "password": 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end

    expect(response.status).to eq(400)
    expect(response.body).to eq('"Required information missing or incorrect"')

    body2 = {
      "email": 'whatever@example.com',
      "password_confirmation": 'password'
    }

    response2 = conn('/api/v1/users').post do |request|
      request.body = body2
    end

    expect(response2.status).to eq(400)
    expect(response2.body).to eq('"Required information missing or incorrect"')
  end

  it 'inclusion of email, password and confirmation but lack of value for any returns 400 code' do
    body = {
      "email": '',
      'password': 'password',
      "password_confirmation": 'password'
    }

    response = conn('/api/v1/users').post do |request|
      request.body = body
    end

    expect(response.status).to eq(422)
    expect(response.body).to eq('Required information missing')

    body2 = {
      "email": 'dude@email.com',
      'password': '',
      "password_confirmation": 'password'
    }

    response2 = conn('/api/v1/users').post do |request|
      request.body = body2
    end

    expect(response2.status).to eq(422)
    expect(response2.body).to eq('Required information missing')
  end

  it "when password and confirmation don't match, 403 code is sent" do
    body = {
      'email': 'dude@email.com',
      'password': 'password',
      'password_confirmation': 'nope'
    }

    response = conn('/api/v1/users').post do |req|
      req.body = body
    end

    expect(response.status).to eq(422)
    expect(response.body).to eq('Required information missing')
  end
end
