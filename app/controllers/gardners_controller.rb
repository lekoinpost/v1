class GardnersController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :show, :new ]
  before_action :set_gardner, only: [:show, :create, :edit, :update]

  def index
    scope = Gardner.all
    if params[:address].present?
      scope = scope.by_address(params[:address])
    end
    @pagy, @gardners = pagy_array(scope, items: 9, locale: :fr)

    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { gardners: @gardners } }
    end

    @markers = scope.geocoded.map do |gardner|
      {
        lat: gardner.latitude,
        lng: gardner.longitude, 
        info_window_html: render_to_string(partial: "info_window", locals: {gardner: gardner}), 
        marker_html: render_to_string(partial: "marker")
      }
    end



  end

  def new
    @gardner = Gardner.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end


  private

  def set_gardner
    if params[:id]
      @gardner = Gardner.find(params[:id])
    elsif params[:slug]
      @gardner = Gardner.find_by_slug(params[:slug].downcase)
    end
  end

  def gardner_params
    params.require(:gardner).permit(:first_name, :last_name, :email, :password, :garden_name, :description, :street, :zipcode, :city, :main_image, products: [])
  end

end
