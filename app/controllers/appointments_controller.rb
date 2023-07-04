class AppointmentsController < ApplicationController

  before_action :set_garden, only: [:create]
  before_action :set_appointment, only: [:mark_as_confirmed]

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
    @appointment = Appointment.new(appointment_params)
    @appointment.gardener_id = @garden.id
    if @appointment.save
      redirect_to appointments_path, notice: "Votre demande a bien été envoyée à #{@garden.garden_name}!"
      UserMailer.with(gardener: @appointment.gardener, giver: @appointment.giver, appointment: @appointment).new_appointment_notification.deliver_now
    else
      redirect_to garden_path(slug: @garden.slug)
    end
  end

  def mark_as_confirmed
    @appointment.update(status: "confirmed")
    @appointment.update_giver_garden_points
    flash[:notice] = 'Merci d\'avoir confirmé ce don ! 🎉'
    redirect_back(fallback_location: root_path)

    @nb_of_points = GiverGardenPoint.find_by(giver_id: @appointment.giver.id, garden_id: @appointment.gardener.garden.id).nb_of_points
    @nb_of_rewards = Reward.where(giver_id: @appointment.giver.id, gardener_id: @appointment.gardener, used: false).size
    UserMailer.with(gardener: @appointment.gardener, giver: @appointment.giver, appointment: @appointment, nb_of_points: @nb_of_points, nb_of_rewards: @nb_of_rewards ).confirmed_appointment_notification.deliver_now
  end

  private

  def appointment_params
    params.require(:appointment).permit(:giver_id, :gardener_id, :date, :quantity, :compost_type)
  end

  def set_appointment 
    @appointment = Appointment.find(params[:appointment])
  end

  def set_garden
    @garden = Garden.find(params[:appointment][:garden_id])
  end

end
