require 'rails_helper'

describe RoadTrip do
  it 'Creates a RoadTrip object with specific attributes' do
    data = {
      start: 1_595_242_800,
      finish: 22,
      eta: 22,
      weather: {temp: 23.5, weather: [{description: 'Nice and good'}]}
    }
    trip = RoadTrip.new(data)
    require "pry"; binding.pry
  end
end
