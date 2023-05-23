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
    @rewards = current_user.giver_gardener_points.includes(:gardener).group_by(&:gardener)
    @pending_rewards = @rewards.select { |_, points| points.sum { |point| point.nb_of_points.to_i } < points.first.gardener.nb_of_points_for_a_gift }
    @reached_rewards = @rewards.select { |_, points| points.sum { |point| point.nb_of_points.to_i } == points.first.gardener.nb_of_points_for_a_gift }
  end

  private

  def set_giver
    @giver = current_user
  end

end
