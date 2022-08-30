Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :applications,only: [:index, :show, :update, :create], defaults: {format: :json} do
        resources :chats ,only: [:index, :show, :update], defaults: {format: :json} do
          get "messages/search" => "messages#search"
          resources :messages, only: [:index, :show, :update], defaults: {format: :json}
        end
      end
    end
  end
end
