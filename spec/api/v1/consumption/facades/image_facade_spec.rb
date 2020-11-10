# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Image Facade' do
  it '.get_image(info)' do
    info = 'denver,co'
    result = ImageFacade.get_image(info)
    expect(result).to be_a(Hash)

    expect(result.keys).to eq(%i[query results])
    expect(result[:query]).to eq(info.to_s)

    expect(result[:results].keys).to eq(%i[total total_pages results])

    expected = %i[id color urls user categories links]
    result[:results].each do |key, value|
      if key != :results
        expect(value).to be_an(Integer)
      else
        value.each do |image|
          expect(image.keys.length).to eq(19)
        end
        expected.each do |name|
          value.each do |image|
            expect(image.keys.include?(name)).to eq(true)
          end
        end
      end
    end
  end
end
