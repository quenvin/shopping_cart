Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"
  resources :products do
    put 'add_cart', on: :member
    put 'remove_cart', on: :member
  end

  resources :categories

  resources :users do
    resources :orders
    get 'cart', on: :member
  end

  

end