# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer

  attribute :email do |data|
    data[:email]
  end

  attribute :api_key do |data|
    data[:api_key]
  end
end
