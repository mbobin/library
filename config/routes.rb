Rails.application.routes.draw do
  root 'library#index'
  resources :books, only: [:show, :index]
  resources :library, only: :index
  resources :logs, only: :index
  resources :documents, only: :show do
    get :download, on: :member
  end
end
