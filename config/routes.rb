# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :forecast do
        get '/', to: 'search#show'
      end

      namespace :backgrounds do
        get '/', to: 'search#show'
      end
      namespace :users do
        post '/', to: 'user#create'
        delete '/', to: 'user#destroy'
      end
      namespace :road_trip do
        post '/', to: 'trip#create'
      end
    end
  end
end
