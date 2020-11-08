# frozen_string_literal: true

class ErrorSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
end
