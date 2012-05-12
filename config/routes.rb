UserGroup::Application.routes.draw do
  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, :only => [ :create, :destroy ]
  end

  resources :pages, :except => :show

  match ':section_name/:page_name' => 'pages#show', :as => :section_page, :via => :get

  root :to => 'dummy#index'
end
