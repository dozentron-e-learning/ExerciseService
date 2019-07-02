Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :exercises do
        member do
          get 'download'
          get 'download_hidden'
          get 'download_stub'
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
