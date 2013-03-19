UserGroup::Application.routes.draw do

  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, :only => [ :create, :destroy ] do
      collection do
        get :login, :as => :new
      end
    end
  end

  namespace :dashboard do
    resources :pages, :only => [ :create, :update, :new, :edit, :destroy ]
    resources :posts, :only => [ :create, :update, :new, :edit, :destroy ]
  end

  resources :users, :only => [:show, :edit, :update] do
    resources :posts, :only => [ :index, :show ]
  end

  resources :posts, :only => :index

  match 'contact'       => 'pages#contact', :as => :contact_page, :via => :get
  match 'contact/send'  => 'pages#email',   :as => :send_email,   :via => :post

  match ':section_name/:page_name' => 'pages#show', :as => :section_page, :via => :get

  root :to => 'pages#main'
end
