# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'api_key' do
    it 'api_key is generated and assigned upon creation' do
      user = User.create!(email: 'hello@email.com', password: 'yep')

      expect(user.api_key).to_not be_nil
      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(24)
    end
  end

  describe 'methods' do
    it '.self.check_email()' do
      User.create!(email: 'hello@email.com', password: 'yep')
      data = { 'email': 'hello@email.com' }

      expect(User.check_email(data)).to eq(false)
    end

    it 'self.check_params()' do
      data = { 'email' => 'hello@email.com' }
      data2 = { 'email' => 'hello', 'password' => 'yep', 'password_confirmation' => 'yep' }

      expect(User.check_params(data)).to eq(false)
      expect(User.check_params(data2)).to eq(true)
    end

    it 'self.check_key(key)' do
      result = User.check_key('8879')
      expect(result).to eq(false)

      user = User.create!(email: 'yessire@email.com', password: 'yep')
      expect(User.check_key(user.api_key.to_s)).to eq(true)
    end
  end
end
