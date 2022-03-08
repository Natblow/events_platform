Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :new, :edit, :update, :destroy]
  resources :events do
    get :myevents, to: 'events#myevents', on: :collection
    post :attendee, to: 'attendees#create', on: :member
    post :unattend, to: 'attendees#destroy', on: :member
  end
  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
