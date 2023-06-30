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

  private

  def set_giver
    @giver = current_user
  end

end
