require 'rails_helper'

RSpec.describe 'Background image API has multiple attributes' do
  before(:each) do
    location = 'denver,co'
    get "/api/v1/backgrounds?location=#{location}"

    expect(response).to be_successful
    @json = JSON.parse(response.body)
  end

  it 'gets specific info, in specific format' do
    expect(@json.keys).to eq(['data'])
    expected_credit_keys = %w[source author logo]

    extra_attributes_in_data = []
    extra_attributes_in_credit = []


    @json['data'].each do |key, value|
      if key == 'type'
        expect(value).to eq('image')
      elsif key == 'id'
        expect(value).to eq(nil)

      elsif key == 'attributes'
        expect(value).to be_a(Hash)
        expect(value.keys).to eq('image')

        value.each do |k,v|

          if k == 'location'
            expect(v).to eq(location)

          elsif k == 'image_url'
            expect(v).to be_a(String)

          elsif k == 'credit'
            expect(v).to be_a(Hash)

            expect(v.keys).to eq(expected_credit_keys)
            v.values.each do |attr|
              expect(attr).to be_a(String)
            end

            v.keys.each do |name|
              if !expected_credit_keys.include?(name)
                extra_attributes_in_credit << name
              end
            end
          end
        end
      else
        extra_attributes_in_data << value
      end
    end

    expect(extra_attributes_in_data).to be_empty
    expect(extra_attributes_in_credit).to be_empty

  end
end
