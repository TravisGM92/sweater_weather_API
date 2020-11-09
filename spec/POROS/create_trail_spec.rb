# frozen_string_literal: true

require 'rails_helper'

describe CreateTrail do
  it 'Creates a trail object with specific attributes' do
    data = {
      name: 'George',
      summary: 'Awesome trail',
      difficulty: 'Extremely medium',
      location: 'boulder,co'
    }
    start = 'denver,co'
    trail = CreateTrail.new(data, start)

    expect(trail).to be_a(CreateTrail)
    expect(trail.name).to be_a(String)
    expect(trail.summary).to be_a(String)
    expect(trail.difficulty).to be_a(String)
    expect(trail.location).to be_a(String)
    expect(trail.distance_to_trail).to be_a(Float)
  end
end
