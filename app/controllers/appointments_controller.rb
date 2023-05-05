class AppointmentsController < ApplicationController

  # before_action :set_users, only: [:create]

  def new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to root_path, notice: "Votre demande a bien été envoyée."
    else
      redirect_to gardner_path(slug: @gardner.slug)
      raise
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:giver_id, :gardner_id, :date, :quantity, :compost_type)
  end

end
