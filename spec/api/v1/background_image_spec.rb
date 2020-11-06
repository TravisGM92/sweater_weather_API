require 'rails_helper'

RSpec.describe 'Background image API has multiple attributes' do
  before(:each) do
    @location = 'denver,co'
    get "/api/v1/backgrounds?location=#{@location}"

    expect(response).to be_successful
    @json = JSON.parse(response.body)
  end

  it 'gets specific info, in specific format' do
    expect(@json.keys).to eq(['data'])
    expect(@json['data'].keys).to eq(%w[id type attributes])
    expect(@json['data']['id']).to be_nil
    expect(@json['data']['type']).to eq('image')

    expect(@json['data']['attributes'].keys).to eq(['image'])
    expect(@json['data']['attributes']['image'].keys).to eq(%w[location image_url credit])
    expect(@json['data']['attributes']['image']['location']).to eq(@location)
    expect(@json['data']['attributes']['image']['image_url']).to be_a(String)

    expect(@json['data']['attributes']['image']['credit']).to be_a(Hash)
    expect(@json['data']['attributes']['image']['credit'].keys).to eq(%w[source author portfolio image_links])
    expect(@json['data']['attributes']['image']['credit']['source']).to eq('unsplash.com')
    expect(@json['data']['attributes']['image']['credit']['author']).to be_a(String)
    expect(@json['data']['attributes']['image']['credit']['portfolio']).to be_a(String)
    expect(@json['data']['attributes']['image']['credit']['image_links']).to be_a(Hash)

    expect(@json['data']['attributes']['image']['credit']['image_links'].keys).to eq(%w[raw full regular small thumb])
    @json['data']['attributes']['image']['credit']['image_links'].values.each do |name|
      expect(name).to be_a(String)
    end
  end
end
