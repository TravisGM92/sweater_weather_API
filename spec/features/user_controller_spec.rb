# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User controller' do
  describe 'methods' do
    it '.create' do
      def conn(uri)
        url = ENV['RAILS_ENGINE_DOMAIN'] + uri
        Faraday.new(url)
      end

      body = {
        "email": 'whatever2@example.com',
        "password": 'password',
        "password_confirmation": 'password'
      }

      response = conn('/api/v1/users').post do |request|
        request.body = body
      end

      delete_response = conn('/api/v1/users').delete
      expect(delete_response.status).to eq(204)
    end
  end
end
