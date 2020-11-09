# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserController < ApplicationController
        def create
          if !User.check_params(user_params)
            self.status = 400
            self.response_body = 'Required information missing or incorrect'.to_json
            ErrorSerializer.new(user_params)
          elsif User.check_email(user_params)
            self.status = 403
            self.response_body = 'Credentials are bad'.to_json
            ErrorSerializer.new(user_params).to_json
          elsif user_params.values.any?('') || user_params[:password] != user_params[:password_confirmation]
            self.status = 422
            self.response_body = 'Required information missing'
            ErrorSerializer.new(user_params)
          else
            render json: UserSerializer.new(User.create!(user_params))
          end
        end

        def destroy
          User.last.delete
        end

        private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
