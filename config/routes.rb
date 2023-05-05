Rails.application.routes.draw do
  devise_for :users
  
  #Static
  root to: "pages#home"
  get 'mentions-legales', to: "pages#terms_and_conditions"

  # Jardins
  get 'jardins',        to: "gardners#index", as: :gardners
  get 'jardins/:slug',  to: 'gardners#show', as: :gardner
  get 'creer-un-jardin', to: "gardners#new", as: :new_gardner

  # Appointments
  post 'appointments', to: "appointments#create", as: :create_appointment

end
