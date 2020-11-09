# frozen_string_literal: true

class GeoCodeService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.get_coordinates(info)
    response = conn.get('geocoding/v1/address') do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:location] = info
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
