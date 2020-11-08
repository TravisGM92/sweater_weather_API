# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserController < ApplicationController
        def create
          if !User.check_params(user_params)
            self.status = 400
            self.response_body = 'Required information missing'.to_json
            ErrorSerializer.new(user_params)
          elsif User.check_email(user_params)
            self.status = 403
            self.response_body = 'Credentials are bad'.to_json
            ErrorSerializer.new(user_params).to_json
          else
            render json: UserSerializer.new(User.create!(user_params))
          end
        end

        private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
