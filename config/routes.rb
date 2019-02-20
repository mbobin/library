Rails.application.routes.draw do
  devise_for :users

  root 'library#index'
  resources :books, only: [:show, :index, :edit, :update] do
    resources :collections, only: [:edit, :update, :destroy], module: "books"
  end

  resources :library, only: :index
  resources :logs, only: :index
  resources :halted_files, only: :destroy
  resources :documents, only: :show do
    get :download, on: :member
    post :convert, on: :member
  end
  resources :collections, only: [:index, :new, :create]
end
