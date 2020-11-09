# frozen_string_literal: true

class TrailService
  def self.conn
    Faraday.new('https://www.hikingproject.com')
  end

  def self.get_trails(coords)
    lat = coords.split(', ')[0].to_f
    lon = coords.split(', ')[1].to_f
    response = conn.get('data/get-trails') do |req|
      req.params[:lat] = lat
      req.params[:lon] = lon
      req.params[:key] = ENV['HIKE_KEY']
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
