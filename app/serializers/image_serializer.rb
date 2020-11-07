# frozen_string_literal: true

class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attribute :image do |data|
    {
      'location': data[:query],
      'image_url': data[:results][:results][0][:urls][:raw],
      'credit': self.image_credit(data[:results][:results][0][:urls], data[:results][:results][0][:user])
    }
  end

  def self.image_credit(url, credit)
    {
      'source': "#{url[:raw].split(".com")[0].split(".")[-1]}" + ".com",
      'author': credit[:name],
      'portfolio': credit[:links][:self],
      'image_links': url
    }
  end
end
