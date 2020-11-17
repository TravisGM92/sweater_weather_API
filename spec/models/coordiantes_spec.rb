# frozen_string_literal: true

require 'rails_helper'

describe Coordinates, type: :model do
  describe 'validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :area }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end

  describe 'once API call is made the coordinates are saved' do

    def conn(uri)
      url = "https://www.mapquestapi.com#{uri}"
      Faraday.new(url)
    end

    it 'saved coordinates' do
      info = 'miami,fl'

      expect(Coordinates.all.empty?).to eq(true)

      GeoCodeService.get_coordinates(info)

      expect(Coordinates.all.empty?).to eq(false)
    end

    it 'if a city and its coordinates are already in the system, an API call is not made' do
      info = 'miami,fl'

      expect(Coordinates.all.empty?).to eq(true)

      info1 = GeoCodeService.get_coordinates(info)
      expect(Coordinates.all.empty?).to eq(false)

      info = GeoCodeService.get_coordinates(info)
      expect(info1.class).to eq(Hash)
      expect(info.first.class).to eq(Coordinates)
    end
  end
end
