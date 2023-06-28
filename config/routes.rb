Rails.application.routes.draw do
  devise_for :users
  
  #Static
  root to: "pages#home"
  get 'mentions-legales', to: "pages#terms_and_conditions"

  # Jardins
  get 'jardins',        to: "gardens#index", as: :gardens
  get 'jardins/:slug',  to: 'gardens#show', as: :garden
  get 'creer-un-jardin', to: "gardens#new", as: :new_garden
  post 'creer-un-jardin', to: 'gardens#create', as: :create_garden
  get 'modifier-mon-jardin/:slug', to: "gardens#edit", as: :edit_garden
  patch 'modifier-mon-jardin/:slug', to: 'gardens#update', as: :update_garden

  # Appointments
  post 'appointments', to: "appointments#create", as: :create_appointment
  get 'mon-espace/mes-rendez-vous', to: "appointments#index", as: :appointments

  # Givers
  get 'mon-compte', to: "givers#edit", as: :giver_edit_profile
  get 'mon-espace/mes-recompenses', to: "givers#rewards", as: :giver_rewards

  # Conversations
  get "messagerie", to: "conversations#index", as: :conversations
  resources :conversations, path: "messagerie", only: :show do
    resources :messages, only: :create
  end

end
