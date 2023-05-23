class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name type garden_name description nb_of_points_for_a_gift street zipcode city slug latitude longitude address])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name type garden_name description nb_of_points_for_a_gift street zipcode city slug latitude longitude address])
  end


end
