# frozen_string_literal: true

module Api
  module V1
    module Backgrounds
      class SearchController < ApplicationController
        def show
          render json: ImageSerializer.new(ImageFacade.get_image(params[:location]))
        end
      end
    end
  end
end
