RSpec.describe 'Forecast API has multiple attributes' do
  it 'gets specific info, in specific format' do
    get '/api/v1/trails?location=denver,co'

    expect(response).to be_successful
    trail = JSON.parse(response.body)

    expect(trail['data'].keys).to eq(%w[id type attributes])
    expect(trail['data']['id']).to be_nil
    expect(trail['data']['type']).to eq('trail')
    expect(trail['data']['attributes']).to be_a(Hash)

    expect(trail['data']['attributes'].keys).to eq(%w[location forecast trails])
    expect(trail['data']['attributes']['location']).to be_a(String)
    expect(trail['data']['attributes']['forecast']).to be_a(Hash)

    expect(trail['data']['attributes']['forecast'].keys).to eq(%w[summary temperature])
    trail['data']['attributes']['forecast'].values.each do |name|
      expect(name).to be_a(String)
    end

    expect(trail['data']['attributes']['trails'].keys).to eq(%w[name summary difficulty location distance_to_trail])
    trail['data']['attributes']['trails'].values.each do |name|
      expect(name).to be_a(String)
    end
  end
end
