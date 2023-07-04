class RewardsController < ApplicationController
  include RewardsHelper
  before_action :set_user
  before_action :set_reward, only: [:mark_as_confirmed]
  before_action :rewards_to_give

  def rewards_to_receive
    set_rewards_to_receive
  end

  def received_rewards
    set_received_rewards
  end
  
  def rewards_to_give
    set_rewards_to_give
  end

  def given_rewards
    set_given_rewards
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
