# frozen_string_literal: true

class MapService
  def self.conn
    Faraday.new('https://www.mapquestapi.com')
  end

  def self.get_distance(start, finish)
    response = conn.get('directions/v2/route') do |req|
      req.params[:key] = ENV['MAP_KEY']
      req.params[:from] = start
      req.params[:to] = finish
      req.params[:routeType] = 'fastest'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
