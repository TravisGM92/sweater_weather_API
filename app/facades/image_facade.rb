# frozen_string_literal: true

class ImageFacade
  def self.get_image(info)
    ImageService.get_image(info)
  end
end
