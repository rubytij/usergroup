UserGroup::Application.routes.draw do
  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, :only => [ :create, :destroy ]
  end

  resources :sections do
    resources :pages, :only => :show
  end

  resources :pages, :except => :show

  root :to => 'dummy#index'
end
