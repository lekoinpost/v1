class AppointmentsController < ApplicationController

  before_action :set_appointment, only: [:mark_as_confirmed, :mark_as_refused]

  def index
    if params[:date]
      start_date = Date.parse(params[:date])
    else
      start_date = params.fetch(:start_date, Date.today).to_date
    end
    @appointments = Appointment.by_user(current_user)
                                .in_same_month_as(start_date)
    if params[:category]=="passed"
      @appointments = @appointments.passed.order(date: :desc)
    else
      @appointments = @appointments.upcoming.order(date: :asc)
    end
    if params[:selected_date]
      @selected_date = Date.parse(params[:selected_date])
      @selected_appointments  = @appointments.filter_by_date(@selected_date)
    else
      @selected_date = nil
      @selected_appointments = @appointments
    end

  end

  def new
  end

  def create
    @garden = Garden.where(gardener_id: appointment_params[:gardener_id]).first
    @appointment = Appointment.new(appointment_params)
    if appointment_params[:date].present?
      @appointment.date = Date.parse(appointment_params[:date])
    end
    if @appointment.save
      flash[:notice] = "Votre demande a bien été envoyée à #{@appointment.gardener.garden.garden_name}!"
      redirect_to appointments_path
      UserMailer.with(appointment: @appointment).new_appointment_notification.deliver_now
    else
      puts "missing item"
      redirect_to url_for(controller: 'gardens', action: 'show', slug: @garden.slug, error: "Merci de sélectionner une date et un type de compost.", anchor: 'new-appointment')

    end

  end

  def mark_as_confirmed
    @appointment.update(status: "confirmed")
    @appointment.update_giver_garden_points
    flash[:notice] = 'Merci d\'avoir confirmé ce don ! 🎉'
    redirect_back(fallback_location: root_path)

    @nb_of_points = GiverGardenPoint.find_by(giver_id: @appointment.giver.id, garden_id: @appointment.gardener.garden.id).nb_of_points
    @nb_of_rewards = Reward.where(giver_id: @appointment.giver.id, gardener_id: @appointment.gardener, used: false).size
    UserMailer.with(appointment: @appointment, nb_of_points: @nb_of_points, nb_of_rewards: @nb_of_rewards ).confirmed_appointment_notification.deliver_now
  end

  def mark_as_refused
    @appointment.update(status: "refused")
    redirect_back(fallback_location: root_path)
  end

  private

  def appointment_params
    params.require(:appointment).permit(:giver_id, :gardener_id, :date, :quantity, :compost_type)
  end

  def set_appointment 
    @appointment = Appointment.find(params[:appointment])
  end

end
