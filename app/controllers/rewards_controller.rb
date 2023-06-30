class RewardsController < ApplicationController

  before_action :set_user
  before_action :set_reward, only: [:mark_as_confirmed]

  def rewards_to_receive
    @rewards_to_receive = Reward.by_giver(@user)
                                .where(used: false)
                                .includes(:gardener)
                                .group(:gardener)
                                .count
    
    @pending_rewards = GiverGardenPoint.where(giver: @user)
                                  .includes(:garden)
                                  .group_by(&:garden)
                                  .select { |_, points| points.sum { |point| point.nb_of_points.to_i } < points.first.garden.nb_of_points_for_a_gift }
  end

  def received_rewards
    @received_rewards = Reward.by_giver(@user)
                                .where(used: true)
                                .includes(:gardener)
                                .group(:gardener)
                                .count
  end
  
  def rewards_to_give
    @rewards_to_give = Reward.by_gardener(@user.garden)
                                .where(used: false)
                                .includes(:giver, :gardener)
                                .group(:giver_id, :gardener_id)
                                .count

    @pending_rewards = GiverGardenPoint.where(garden: @user.garden)
                            .includes(:giver)
                            .group_by(&:giver)
                            .select { |_, points| points.sum { |point| point.nb_of_points.to_i } < points.first.garden.nb_of_points_for_a_gift }
  end

  def given_rewards
    @given_rewards = Reward.by_gardener(@user.garden)
                                .where(used: true)
                                .includes(:giver, :gardener)
                                .group(:giver_id, :gardener_id)
                                .count
  end



  def mark_as_confirmed
    rewards_to_update = Reward.where(giver_id: @reward.giver_id, gardener_id: @reward.gardener_id, used: false)
    rewards_to_update.update_all(used: true)
    flash[:notice] = 'Merci d\'avoir confirmé cette récompense ! 🎉'
    redirect_to given_rewards_path
  end

  private

  def set_user
    if params["user"]
      @user = User.find(params["user"])
    else
      @user = current_user
    end
  end

  def set_reward 
    @reward = Reward.find(params[:reward])
  end

end
