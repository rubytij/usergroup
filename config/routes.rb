UserGroup::Application.routes.draw do
  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, :only => [ :create, :destroy ] do
      collection do
        get :login, :as => :new
      end
    end
  end

  resources :posts, :except => :show
  resources :pages, :except => :show

  resources :user, :only => [] do
    resources :posts, :only => [ :index, :show ]
  end

  match ':section_name/:page_name' => 'pages#show', :as => :section_page, :via => :get

  root :to => 'posts#index'
end
