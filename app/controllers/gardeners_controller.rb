class GardenersController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :new ]
  before_action :set_gardener, only: [:show, :create, :edit, :update]

  def index
    scope = Gardener.all
    if params[:address].present?
      scope = scope.by_address(params[:address])
    end
    @pagy, @gardeners = pagy_array(scope, items: 9, locale: :fr)

    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { gardeners: @gardeners } }
    end

    @markers = scope.geocoded.map do |gardener|
      {
        lat: gardener.latitude,
        lng: gardener.longitude, 
        info_window_html: render_to_string(partial: "info_window", locals: {gardener: gardener}), 
        marker_html: render_to_string(partial: "marker")
      }
    end



  end

  def new
    @gardener = Gardener.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @appointment = Appointment.new
  end


  private

  def set_gardener
    if params[:id]
      @gardener = Gardener.find(params[:id])
    elsif params[:slug]
      @gardener = Gardener.find_by_slug(params[:slug].downcase)
    end
  end

  def gardener_params
    params.require(:gardener).permit(:first_name, :last_name, :email, :password, :garden_name, :description, :street, :zipcode, :city, :main_image, products: [])
  end

end
