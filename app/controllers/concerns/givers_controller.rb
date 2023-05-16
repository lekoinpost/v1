class GiversController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :new ]
  before_action :set_giver, only: [:rewards, :appointments, :create, :edit, :update]

  def index
    scope = Giver.all
    @pagy, @gardeners = pagy_array(scope, items: 9, locale: :fr)

    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { givers: @givers } }
    end

  end

  def rewards
    @givers_gardeners_points = GiverGardenerPoint.where(giver_id: @giver.id)
  end

  def appointments
    @giver_appointments = Appointment.where(giver: @giver)
    @upcoming_appointments = @giver_appointments.upcoming.order(date: :asc)
    @passed_appointments = @giver_appointments.passed.order(date: :desc)
  end


  private

  def set_giver
    @giver = current_user
  end

end
