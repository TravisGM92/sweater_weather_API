# frozen_string_literal: true

module Api
  module V1
    module Users
      class UserController < ApplicationController
        def create
          if User.validate_info(user_params, self)
            render json: UserSerializer.new(User.create!(user_params))
          else
            User.send_correct_error(user_params, self)
          end
        end

        def destroy
          User.where(email: 'whatever20@example.com').first.delete
        end

        private

        def user_params
          params.permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
