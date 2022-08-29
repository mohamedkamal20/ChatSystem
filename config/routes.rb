Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :applications, defaults: {format: :json} do
        resources :chats ,only: [:index, :show, :update], defaults: {format: :json} do
          resources :messages, only: [:index, :show, :update], defaults: {format: :json}
          get "messages/search" => "messages#search"

        end
      end

    end
  end
end
