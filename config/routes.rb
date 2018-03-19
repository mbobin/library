Rails.application.routes.draw do
  devise_for :users

  root 'library#index'
  resources :books, only: [:show, :index, :edit, :update] do
    resources :collections, only: [:edit, :update, :delete], module: "books"
  end

  resources :library, only: :index
  resources :logs, only: :index
  resources :documents, only: :show do
    get :download, on: :member
  end
  resources :collections, only: :index
end
