# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserController < ApplicationController
        def create
          # render json: ForecastSerializer.new(ForecastFacade.get_weather(params[:location]))
        end

        private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
