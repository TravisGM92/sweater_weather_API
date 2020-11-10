require 'rails_helper'

describe RoadTrip do
  it 'Creates a RoadTrip object with specific attributes' do
    data = {
      start: 'denver,co',
      finish: 'boulder,co',
      eta: 22,
      weather: {temp: 23.5, weather: [{description: 'Nice and good'}]}
    }

    expected = {:temperature=>23.5, :conditions=>"Nice and good"}
    trip = RoadTrip.new(data)

    expect(trip).to be_a(RoadTrip)
    expect(trip.start_city).to eq(data[:start])
    expect(trip.end_city).to eq(data[:finish])
    expect(trip.travel_time).to be_a(String)
    expect(trip.weather_at_eta).to eq(expected)
  end
end
