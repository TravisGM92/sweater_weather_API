# frozen_string_literal: true

module Api
  module V1
    module Trails
      class SearchController < ApplicationController
        def show
          result = TrailFacade.get_trail_info(params[:location])
          if result == 'location not found'
            self.status = 400
            self.response_body = 'Location not found'
            LocationErrorSerializer.new(params).to_json
          else
            render json: TrailSerializer.new(result)
          end
        end
      end
    end
  end
end
