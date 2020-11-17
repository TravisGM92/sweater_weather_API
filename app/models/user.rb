# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :api_key

  before_validation :set_api_key
  has_secure_password

  def self.check_email(data)
    !User.where(email: data['email']).empty?
  end

  def self.check_params(data)
    data.keys.include?('email') && data.keys.include?('password') && data.keys.include?('password_confirmation')
  end

  def self.check_key(key)
    !User.where(api_key: key).empty?
  end

  def self.validate_info(data, obj)
    if !check_params(data) || check_email(data) || data.values.any?('') || data[:password] != data[:password_confirmation]
      false
    else
      true
    end
  end

  def self.send_correct_error(data, obj)
    if !User.check_params(data)
      obj.status = 400
      obj.response_body = 'Required information missing or incorrect'.to_json
      ErrorSerializer.new(data)
    elsif User.check_email(data)
      obj.status = 403
      obj.response_body = 'Credentials are bad'.to_json
      ErrorSerializer.new(data).to_json
    elsif data.values.any?('') || data[:password] != data[:password_confirmation]
      obj.status = 422
      obj.response_body = 'Required information missing'
      ErrorSerializer.new(data)
    end
  end

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
