# frozen_string_literal: true

module Api
  module V1
    module Forecast
      class SearchController < ApplicationController
        def show
          render json: ForecastSerializer.new(ForecastFacade.get_weather_by_coordinates(params[:location]))
        end
      end
    end
  end
end
