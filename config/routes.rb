Rails.application.routes.draw do
  devise_for :users
  
  #Static
  root to: "pages#home"
  get 'mentions-legales', to: "pages#terms_and_conditions"

  # Jardins
  get 'jardins',        to: "gardeners#index", as: :gardeners
  get 'jardins/:slug',  to: 'gardeners#show', as: :gardener
  get 'creer-un-jardin', to: "gardeners#new", as: :new_gardener

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
