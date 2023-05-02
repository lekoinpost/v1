class GardnersController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_gardner, only: [:show]

  def index
    @gardners = Gardner.all
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
