require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'
Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :applications, param: :token do
        resources :chats, param: :number do
          resources :messages, param: :number
        end
      end
      get 'messages/search', param: :query
    end
  end

  mount Resque::Server.new, at: '/jobs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
