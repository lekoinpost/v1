module RewardsHelper

  def set_rewards_to_receive
    @rewards_to_receive = Reward.by_giver(@user)
                                .where(used: false)
                                .includes(:gardener)
                                .group(:gardener)
                                .count
    
    @pending_rewards_to_receive = GiverGardenPoint.where(giver: @user)
                                  .includes(:garden)
                                  .group_by(&:garden)
                                  # .select { |_, points| points.sum { |point| point.nb_of_points.to_i } < points.:svcfirst.garden.nb_of_points_for_a_gift }
  end

  def set_received_rewards
    @received_rewards = Reward.by_giver(@user)
                                .where(used: true)
                                .includes(:gardener)
                                .group(:gardener)
                                .count
  end
  
  def set_rewards_to_give
    @rewards_to_give = Reward.by_gardener(@user)
                                .where(used: false)
                                .includes(:giver, :gardener)
                                .group(:giver_id, :gardener_id)
                                .count

    @pending_rewards_to_give = GiverGardenPoint.where(garden: @user.garden)
                            .includes(:giver)
                            .group_by(&:giver)
                            .select { |_, points| points.sum { |point| point.nb_of_points.to_i } < points.first.garden.nb_of_points_for_a_gift }
  end

  def set_given_rewards
    @given_rewards = Reward.by_gardener(@user)
                                .where(used: true)
                                .includes(:giver, :gardener)
                                .group(:giver_id, :gardener_id)
                                .count
  end

end