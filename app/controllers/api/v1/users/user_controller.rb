# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserController < ApplicationController
        def create
          render json: UserSerializer.new(User.create!(user_params))
        end

        private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
