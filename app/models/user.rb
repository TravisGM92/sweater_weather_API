# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :api_key

  before_validation :set_api_key
  has_secure_password

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
