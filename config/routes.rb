Rails.application.routes.draw do
  post 'login', to: 'welcome#login', as: 'login'
  delete 'logout', to: 'welcome#logout', as: 'logout'

  resources 'drinks' do
    member do
      put 'toggle/favourite', to: 'drinks#toggle_favourite', as: 'toggle_favourite'
      put 'toggle/completed', to: 'drinks#toggle_complete', as: 'toggle_completed'
    end
  end
  resources 'casks', only: [:index, :show]

  root to: 'welcome#index'
end