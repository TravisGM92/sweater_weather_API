module Api
  module V1
    module Forecast
      class SearchController < ApplicationController
        def show
          render json: ForecastSerializer.new(ForecastFacade.get_weather(params[:location]))
        end
      end
    end
  end
end
