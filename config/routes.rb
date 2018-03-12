Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"
  
  resources :products do
    put 'add_cart', on: :member
    put 'remove_cart', on: :member
    get 'search', on: :collection
    get 'catalog', on: :member
  end

  resources :categories

  resources :users do
    resources :orders, except: [:edit, :destroy, :update] do
      put 'authorized', on: :member
      put 'unauthorized', on: :member
    end
    get 'cart', on: :member
  end

  

end