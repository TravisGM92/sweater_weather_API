class Forecast
  def self.get_direction(numb)
    if numb < 180
      if numb > 90
        "South-east"
      else
        "North-east"
      end
    else
      if numb < 270
        "South-west"
      else
        "North-west"
      end
    end
  end
end
