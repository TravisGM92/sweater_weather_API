# frozen_string_literal: true

require 'rails_helper'

describe Forecast, type: :model do
  it '.get_direction()' do
    expect(Forecast.get_direction(10)).to eq('North')
    expect(Forecast.get_direction(180)).to eq('South')
    expect(Forecast.get_direction(90)).to eq('East')
    expect(Forecast.get_direction(270)).to eq('West')

    expect(Forecast.get_direction(45)).to eq('North-east')
    expect(Forecast.get_direction(135)).to eq('South-east')
    expect(Forecast.get_direction(225)).to eq('South-west')
    expect(Forecast.get_direction(315)).to eq('North-west')

    (1..360).to_a.each do |numb|
      result = Forecast.get_direction(numb)
      expect(result).to be_a(String)
      expect(result).to_not eq('This formula only accepts meterological degrees (any number between 1 and 360)')
    end
    number = (361..10_000).to_a.shuffle.pop
    expect(Forecast.get_direction(number)).to eq('This formula only accepts meterological degrees (any number between 1 and 360)')
  end
end
