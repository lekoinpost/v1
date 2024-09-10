class GardensController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :show,  ]
  before_action :set_garden, only: [:create, :edit, :update, :show, :destroy, :toggle_status]

  def index
    scope = Garden.all.where(status: "active")
    if params[:address].present?
      scope = scope.by_address(params[:address])
    end
    @pagy, @gardens = pagy_array(scope, items: 9, locale: :fr)

    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { gardens: @gardens } }
    end

    @markers = scope.geocoded.map do |garden|
      {
        lat: garden.latitude,
        lng: garden.longitude, 
        info_window_html: render_to_string(partial: "info_window", locals: {garden: garden}), 
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def new
    if user_signed_in? && current_user.has_a_garden?
      redirect_to edit_garden_path(current_user.garden.slug)
    else
      @garden = Garden.new
    end
  end

  def create
    @garden = Garden.new(garden_params)
    current_user.garden = @garden
    @garden.set_slug
    set_products
    
    respond_to do |format|
      if @garden.save
        format.html { redirect_to garden_path(slug: @garden.slug)}
        format.json
      else
        format.html {render "gardens/new", status: :unprocessable_entity}
        format.json
      end
    end
  end

  def edit
  end

  def update
    @garden.update(garden_params)
    @garden.set_slug
    set_products
    if @garden.save
      flash[:notice] = 'Votre jardin a bien été modifié 🎉'
      redirect_to session[:previous_url] || garden_path(slug: @garden.slug)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def show
    @appointment = Appointment.new
  end

  def toggle_status
    if @garden.status == "active"
      @garden.update(status: "inactive")
      flash[:notice] = 'Votre jardin a bien été désactivé ! Il n\'est désormais plus visible. 🎉'
      redirect_to edit_garden_path(slug: @garden.slug), status: :see_other
    else 
      @garden.update(status: "active")
      flash[:notice] = 'Votre jardin a bien été activé ! Il est désormais visible en ligne. 🎉'
      redirect_to garden_path(slug: @garden.slug)
    end
   
  end

  private

  def set_garden
    if params[:id]
      @garden = Garden.find(params[:id])
    elsif params[:slug]
      @garden = Garden.find_by_slug(params[:slug].downcase)
    end
  end

  def garden_params
    params.require(:garden).permit(:garden_name, :description, :address, :street, :zipcode, :city, :nb_of_points_for_a_gift, :main_image, :opening_hours, :status, products_list: [])
  end

  def set_products
    if params[:added_products_list]
      new_products = params[:added_products_list].first.split(',')
      new_products.each do |new_product|
        @garden.products << new_product.strip
      end
    end
    if params[:removed_products_list]
      removed_products = params[:removed_products_list].first.split(',')
      removed_products.each do |removed_product|
        @garden.products.delete(removed_product.strip)
      end
    end
    
  end
  

end
