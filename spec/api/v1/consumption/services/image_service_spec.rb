# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GeoCode API call' do
  def conn(uri)
    url = "https://api.unsplash.com#{uri}"
    Faraday.new(url)
  end

  it 'gets coordinates of a specific location' do
    info = 'denver,co'

    response = conn('/search/photos').get do |req|
      req.params[:page] = 1
      req.params[:query] = info
      req.params[:client_id] = ENV['IMAGE_KEY']
    end

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json.keys).to eq(%w[total total_pages results])
    json.each do |key, value|
      expect(value).to be_an(Integer) if key != 'results'
    end
    expect(json['results']).to be_an(Array)
    expect(json['results'].length).to eq(10)
    json['results'].each do |res|
      expect(res.keys.length).to eq(19)
    end
    expect(json['results'][0].keys.include?('user')).to eq(true)
    expect(json['results'][0].keys.include?('urls')).to eq(true)

    expect(json['results'][0]['user'].keys.length).to eq(17)
    json['results'].each do |name|
      expect(name['user'].keys.include?('id')).to eq(true)
      expect(name['user'].keys.include?('name')).to eq(true)
      expect(name['user'].keys.include?('first_name')).to eq(true)
      expect(name['user'].keys.include?('last_name')).to eq(true)
      expect(name['user'].keys.include?('portfolio_url')).to eq(true)
    end
  end
end
