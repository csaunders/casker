Rails.application.routes.draw do
  get 'signup', to: 'auth#signup', as: 'signup'
  post 'login', to: 'auth#login', as: 'login'
  delete 'logout', to: 'auth#logout', as: 'logout'
  get '/auth/:provider/callback', to: 'auth#callback'

  namespace :admin do
    resources :festivals
    resources :beers
    resources :breweries
    resources :beer_styles
    resources :importers, only: %i(index show create update) do
      post 'finalize'
    end
  end

  get 'admin', to: 'admin/dashboard#index', as: 'admin_dashboard'

  root to: 'brochure#index'

  namespace :legacy do
    post 'login', to: 'welcome#login', as: 'login'
    delete 'logout', to: 'welcome#logout', as: 'logout'
    match 'ghetto', via: [:get, :post], to: 'welcome#ghetto', as: 'ghetto'

    resources 'drinks' do
        member do
        put 'toggle/favourite', to: 'drinks#toggle_favourite', as: 'toggle_favourite'
        put 'toggle/completed', to: 'drinks#toggle_complete', as: 'toggle_completed'
        end
    end
    resources 'casks', only: [:index, :show]
  end
end
