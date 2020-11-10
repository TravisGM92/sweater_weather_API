# frozen_string_literal: true

module Api
  module V1
    module RoadTrip
      class RoadTripController < ApplicationController
        def create
          result = User.check_key(params['api_key'])
          if result
            render json: RoadtripSerializer.new(RoadtripFacade.get_trip(params['origin'], params['destination']))
          end
        end
      end
    end
  end
end
