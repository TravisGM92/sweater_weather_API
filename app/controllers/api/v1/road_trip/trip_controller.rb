# frozen_string_literal: true

module Api
  module V1
    module RoadTrip
      class TripController < ApplicationController
        def create
          result = User.check_key(params['api_key'])
          if result
            TripFacade.get_trip(params['origin'], params['destination'])
          end
        end
      end
    end
  end
end
