class Forecast
  def self.get_direction(numb)
    if numb < 180
      if numb <= 30
        'North'
      elsif numb <= 60 && numb > 30
        'North-east'
      elsif numb > 60 && numb <= 120
        'East'
      elsif numb > 120
        'South-east'
      end
    else
      if numb < 210
        'South'
      elsif numb >= 210 && numb <= 240
        'South-west'
      elsif numb > 240 && numb <= 300
        'West'
      elsif numb > 300 && numb <= 330
        'North-west'
      elsif numb > 330 && numb <= 360
        'North'
      else
        'This formula only accepts meterological degrees (any number between 1 and 360)'
      end
    end
  end
end
