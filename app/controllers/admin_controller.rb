class AdminController < ApplicationController
  before_action :check_admin_role
 
  def dashboard
    @nb_of_users = User.all.count
    @nb_of_gardens = Garden.all.count
    @nb_of_created_appointments = Appointment.all.count
    @nb_of_confirmed_appointments = Appointment.where(status: "confirmed").count
    @nb_of_rewards = Reward.all.count

    @total_confirmed_compost_mur_quantity = Appointment.where(status: "confirmed", compost_type: "compost mûr").sum(:quantity)
    @total_confirmed_biodechets_quantity = Appointment.where(status: "confirmed", compost_type: "biodéchets").sum(:quantity)


  end

  def users_index
    @users = User.all.order(last_name: :asc)
    if params[:query].present?
      sql_subquery = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = @users.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def confirmed_appointments
    @appointments = Appointment.where(status: "confirmed").order(date: :desc)
  end

  def confirmed_rewards
    @rewards = Reward.where(used: true).order(updated_at: :desc)
  end

  private 

  def check_admin_role
    if !current_user.admin?
      raise
    end
  end

end
