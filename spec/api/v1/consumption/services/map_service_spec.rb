# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Map API call' do
  def conn(uri)
    url = "https://www.mapquestapi.com#{uri}"
    Faraday.new(url)
  end








  it 'gets coordinates of a specific location' do
    start = 'denver,co'
    finish = 'boulder,co'

    response = conn('/directions/v2/route').get do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:from] = start
      req.params[:to] = finish
      req.params[:routeType] = 'fastest'
    end



    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    require "pry"; binding.pry


    expect(json.keys).to eq(%w[route info])

    json.each do |key, value|
      if key != 'results'
        expect(value).to be_an(Integer)
      end
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
