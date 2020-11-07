require 'rails_helper'

RSpec.describe 'API Key' do
  describe 'creating an API key' do
    it 'create an API key' do
      key = ApiKey.generator
      expect(key).to be_kind_of(String)
    end
  end
end
