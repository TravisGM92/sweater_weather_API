# frozen_string_literal: true

module Api
  module V1
    module Trails
      class SearchController < ApplicationController
        def show
          render TrailSerializer.new(TrailFacade.get_trail_info(params[:location])).to_json
        end
      end
    end
  end
end
