# frozen_string_literal: true

module Api
  module V1
    module RoadTrip
      class RoadTripController < ApplicationController
        def create
          trip = RoadtripFacade.get_trip(params['origin'], params['destination'])
          result = User.check_key(params['api_key'])
          if result && trip.class != Hash
            render json: RoadtripSerializer.new(trip)
          else
            render json: RoadTripErrorSerializer.new(trip)
          end
        end
      end
    end
  end
end
