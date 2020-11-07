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
end
