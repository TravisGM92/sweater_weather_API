# frozen_string_literal: true

class GeoCodeService
  def self.get_coordinates(info)
    conn = Faraday.new(url: 'https://www.mapquestapi.com')
    response = conn.get("/geocoding/v1/address?key=#{ENV['MAP_KEY']}&inFormat=kvp&outFormat=json&location=#{info}&thumbMaps=false")
    JSON.parse(response.body, symbolize_names: true)
  end
end
