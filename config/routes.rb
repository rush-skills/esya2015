Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", :omniauth_callbacks => "users/omniauth_callbacks"}, skip: [:sessions, :registrations]
  scope 'm' do
    resources :static_pages
    resources :sponsors
    resources :events
    resources :event_admins
    resources :participants
    resources :teams
    resources :participant_teams
    resources :registrations
    get "/" => 'landings#mindex'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'landings#coming_soon'
  get '/abcc/(:type/:value)' => 'landings#home', as: :ide
  get '/coming_soon' => 'landings#index'

  get '/pcj' => redirect("https://docs.google.com/a/iiitd.ac.in/forms/d/1fCqlJgchtazO-ZPOM1TniR_k4OfSOTvABJ584xrQJo4/viewform")
  get '/blog' => redirect("/blog/")
  get '/archive/2014' => redirect("/archive/2014/")
  devise_scope :user do
    get    "users/login"   => "users/sessions#new",         as: :new_user_session
    post   "users/login"   => "users/sessions#create",      as: :user_session
    delete "users/signout" => "users/sessions#destroy",     as: :destroy_user_session
    # get    "signup"  => "users/registrations#new",    as: :new_user_registration
    # post   "signup"  => "users/registrations#create", as: :user_registration
    # put    "signup"  => "users/registrations#update", as: :update_user_registration
    get    "account" => "users/registrations#edit",   as: :edit_user_registration
  end

end
