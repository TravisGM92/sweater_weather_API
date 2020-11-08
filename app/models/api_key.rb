# frozen_string_literal: true

class ApiKey
  def self.generator
    SecureRandom.base64.tr('+/=', 'Qrt')
  end
end
