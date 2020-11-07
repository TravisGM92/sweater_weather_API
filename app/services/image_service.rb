# frozen_string_literal: true

class ImageService
  def self.get_image(info)
    conn = Faraday.new(url: 'https://api.unsplash.com')
    response = conn.get("/search/photos?page=1&query=#{info}&client_id=#{ENV['IMAGE_KEY']}")
    { query: info,
      results: JSON.parse(response.body, symbolize_names: true) }
  end
end
