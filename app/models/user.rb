# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :api_key

  before_validation :set_api_key
  has_secure_password


  def self.check_email(data)
    User.where(email: data['email']).empty?
  end

  def self.check_params(data)
    data.keys.include?(%w[email password password_confirmation])
  end

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
