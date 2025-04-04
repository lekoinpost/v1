Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  get 'contacts/thanks'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: "users/registrations", }


  #Static
  root to: "pages#home"
  get 'faq', to: "pages#faq"
  get 'faq-jardins', to: "pages#faq_for_gardens"
  get 'mentions-legales', to: "pages#terms_and_conditions"

  # Jardins
  get 'jardins',        to: "gardens#index", as: :gardens
  get 'jardins/:slug',  to: 'gardens#show', as: :garden
  get 'creer-un-jardin', to: "gardens#new", as: :new_garden
  post 'creer-un-jardin', to: 'gardens#create', as: :create_garden
  get 'modifier-mon-jardin/:slug', to: "gardens#edit", as: :edit_garden
  patch 'modifier-mon-jardin/:slug', to: 'gardens#update', as: :update_garden
  post 'modifier-le-statut/:slug', to: "gardens#toggle_status", as: :toggle_garden_status

  # Appointments
  post 'appointments', to: "appointments#create", as: :create_appointment
  post 'appointments/confirm', to: "appointments#mark_as_confirmed", as: :confirm_appointment
  post 'appointments/refuse', to: "appointments#mark_as_refused", as: :refuse_appointment
  get 'mon-compte/mes-rendez-vous', to: "appointments#index", as: :appointments

  # Givers
  get 'mon-compte', to: "givers#edit", as: :giver_edit_profile

  # Rewards
  get 'mon-compte/recompenser', to: "rewards#rewards_to_give", as: :rewards_to_give
  get 'mon-compte/recompenser/historique', to: "rewards#given_rewards", as: :given_rewards

  get 'mon-compte/mes-recompenses', to: "rewards#rewards_to_receive", as: :rewards_to_receive
  get 'mon-compte/mes-recompenses/historique', to: "rewards#received_rewards", as: :received_rewards

  post 'rewards', to: "rewards#mark_as_confirmed", as: :confirm_reward

  # Conversations
  get "messagerie", to: "conversations#index", as: :conversations
  resources :conversations, path: "messagerie", only: :show do
    resources :messages, only: :create
  end

  # Admin
  get "admin/gestion-du-site", to: "admin#dashboard", as: :admin_dashboard
  get "admin/utilisateurs", to: "admin#users_index", as: :admin_users_index
  get "admin/rendez-vous-confirmes", to: "admin#confirmed_appointments", as: :admin_confirmed_appointments
  get "admin/recompenses-confirmees", to: "admin#confirmed_rewards", as: :admin_confirmed_rewards

  # Contact
  get "contact", to: "contacts#new", as: :new_contact
  post "contact", to: "contacts#create", as: :create_contact
  get "merci-pour-votre-message", to: "contacts#thanks"

  # SEO
  get '/robots.:format', to: "pages#robots"
  get 'sitemap.xml', to: 'sitemaps#show', as: :sitemap, format: :xml

  
end
