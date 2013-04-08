UserGroup::Application.routes.draw do
  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, only: [ :create, :destroy ] do
      collection do
        get :login, as: :new
      end
    end
  end

  namespace :dashboard do
    resources :pages, except: :show
    resources :posts, except: :show
  end

  resources :user, only: [] do
    resources :posts, only: [ :index, :show ]
  end

  resources :posts, only: :index

  match 'contact'       => 'pages#contact', as: :contact_page, via: :get
  match 'contact/send'  => 'pages#email',   as: :send_email,   via: :post

  match ':section_name/:page_name' => 'pages#show', as: :section_page, via: :get

  root to: 'pages#main'
end
