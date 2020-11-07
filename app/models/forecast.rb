# frozen_string_literal: true

class Forecast
  def self.get_direction(numb)
    if numb < 180
      convert_east(numb)
    elsif numb >= 180 && numb <= 360
      convert_west(numb)
    else
      'This formula only accepts meterological degrees (any number between 1 and 360)'
    end
  end

  def self.convert_east(numb)
    if numb <= 30
      'North'
    elsif numb <= 60 && numb > 30
      'North-east'
    elsif numb > 60 && numb <= 120
      'East'
    elsif numb > 120
      'South-east'
    end
  end

  def self.convert_west(numb)
    if numb < 210
      'South'
    elsif numb >= 210 && numb <= 240
      'South-west'
    elsif numb > 240 && numb <= 300
      'West'
    elsif numb > 300 && numb <= 330
      'North-west'
    else
      'North'
    end
  end

  def self.convert_coordinates(data)
    "#{data[:results][0][:locations][0][:latLng][:lat]}, #{data[:results][0][:locations][0][:latLng][:lng]}"
  end
end
