UserGroup::Application.routes.draw do
  match "auth/:provider/callback" => "user/sessions#create"

  namespace :user do
    resource :session, :only => [ :create, :destroy ]
  end


  resources :user do
    resources :posts, :only => [ :show, :new, :create, :edit, :update ]
  end

  root :to => 'dummy#index'
end
