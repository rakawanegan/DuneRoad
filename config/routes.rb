Rails.application.routes.draw do
  get 'user/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  root "token#index"
  get "token/exhibit" => "token#new" ,as: "exhibit_path" 
  post "token" => "token#create"
  get "token/serch" => "token#search", as: "search_path"
  get "token/purchase" => "token#purchase", as: "purchase_path"
  get "token/download" => "token#download", as: "download_path"
  get "token/release" => "token#release", as: "release_path"
  
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
   } 

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  
  get "users/show" => "user#show" , as: "user_profile"
  get "users/charge" => "user#charge" , as: "charge_path"
  get "users/update_asset" => "user#asset_update" , as: "asset_update_path"
  
end
