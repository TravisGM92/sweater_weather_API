class GeoCodeService
  def self.get_coords(info)
    conn = Faraday.new(url: "https://www.mapquestapi.com")
    response = conn.get("/geocoding/v1/address?key=#{ENV['MAP_KEY']}&inFormat=kvp&outFormat=json&location=#{info}&thumbMaps=false")
    json = JSON.parse(response.body, symbolize_names: true)
    "#{json[:results][0][:locations][0][:latLng][:lat]}, #{json[:results][0][:locations][0][:latLng][:lng]}"
  end
end
