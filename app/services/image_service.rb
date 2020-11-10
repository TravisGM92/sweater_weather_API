# frozen_string_literal: true

class ImageService
  def self.conn
    Faraday.new('https://api.unsplash.com')
  end

  def self.get_image(info)
    response = conn.get('search/photos') do |req|
      req.params[:page] = 1
      req.params[:query] = info
      req.params[:client_id] = ENV['IMAGE_KEY']
    end
    { query: info,
      results: JSON.parse(response.body, symbolize_names: true) }
  end
end
